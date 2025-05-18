package com.RadiantDreams.util;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

/**
 * Utility class for encrypting and decrypting passwords securely using AES-GCM with PBKDF2 key derivation.
 */
public class PasswordUtil {

    private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding";
    private static final int TAG_LENGTH_BIT = 128;   // GCM tag length in bits
    private static final int IV_LENGTH_BYTE = 12;    // IV length for GCM (96 bits)
    private static final int SALT_LENGTH_BYTE = 16;  // Salt length for PBKDF2
    private static final Charset UTF_8 = StandardCharsets.UTF_8;

    /**
     * Generates a random nonce of given number of bytes.
     *
     * @param numBytes length of nonce
     * @return byte array containing random nonce
     */
    public static byte[] getRandomNonce(int numBytes) {
        byte[] nonce = new byte[numBytes];
        new SecureRandom().nextBytes(nonce);
        return nonce;
    }

    /**
     * Generates a random AES key of given key size.
     *
     * @param keysize size in bits (e.g. 128, 256)
     * @return SecretKey object
     * @throws NoSuchAlgorithmException if AES key generation not supported
     */
    public static SecretKey getAESKey(int keysize) throws NoSuchAlgorithmException {
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(keysize, SecureRandom.getInstanceStrong());
        return keyGen.generateKey();
    }

    /**
     * Derives an AES key from the given password and salt using PBKDF2 with HMAC SHA-256.
     *
     * @param password the password chars
     * @param salt     the salt bytes
     * @return derived AES SecretKey
     */
    public static SecretKey getAESKeyFromPassword(char[] password, byte[] salt) {
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(password, salt, 65536, 256);
            return new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            Logger.getLogger(PasswordUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;  // Return null on failure
    }

    /**
     * Encrypts the password using AES-GCM with a key derived from username as password.
     *
     * @param username used as password for key derivation (salted)
     * @param password the plaintext password to encrypt
     * @return Base64-encoded string containing IV + salt + ciphertext
     */
    public static String encrypt(String username, String password) {
        try {
            byte[] salt = getRandomNonce(SALT_LENGTH_BYTE); // Generate random salt
            byte[] iv = getRandomNonce(IV_LENGTH_BYTE);     // Generate random IV
            SecretKey aesKey = getAESKeyFromPassword(username.toCharArray(), salt);

            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.ENCRYPT_MODE, aesKey, new GCMParameterSpec(TAG_LENGTH_BIT, iv));

            byte[] cipherText = cipher.doFinal(password.getBytes(UTF_8));

            // Concatenate IV + salt + ciphertext for storage
            byte[] cipherWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                    .put(iv)
                    .put(salt)
                    .put(cipherText)
                    .array();

            // Return as Base64 string
            return Base64.getEncoder().encodeToString(cipherWithIvSalt);
        } catch (Exception ex) {
            return null; // Return null on error
        }
    }

    /**
     * Decrypts the encrypted password using AES-GCM with key derived from username.
     *
     * @param encryptedPassword Base64 string containing IV + salt + ciphertext
     * @param username          used as password for key derivation (salted)
     * @return decrypted plaintext password or null if decryption fails
     */
    public static String decrypt(String encryptedPassword, String username) {
        try {
            byte[] decoded = Base64.getDecoder().decode(encryptedPassword.getBytes(UTF_8));
            ByteBuffer bb = ByteBuffer.wrap(decoded);

            byte[] iv = new byte[IV_LENGTH_BYTE];
            bb.get(iv);

            byte[] salt = new byte[SALT_LENGTH_BYTE];
            bb.get(salt);

            byte[] cipherText = new byte[bb.remaining()];
            bb.get(cipherText);

            SecretKey aesKey = getAESKeyFromPassword(username.toCharArray(), salt);
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.DECRYPT_MODE, aesKey, new GCMParameterSpec(TAG_LENGTH_BIT, iv));

            byte[] plainText = cipher.doFinal(cipherText);
            return new String(plainText, UTF_8);
        } catch (Exception ex) {
            return null; // Return null on error
        }
    }
}
