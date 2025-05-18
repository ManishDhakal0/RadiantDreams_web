package com.RadiantDreams.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

/**
 * Utility class for handling image uploads.
 */
public class ImageUtil {

    /**
     * Extracts the uploaded image file name from the part.
     * If the filename is missing, generates a default UUID-based filename.
     *
     * @param part the uploaded file part from the request
     * @return filename to use for saving the image
     */
    public String getImageNameFromPart(Part part) {
        String contentDisp = part.getHeader("content-disposition");  // e.g. form-data; name="file"; filename="image.jpg"
        String[] items = contentDisp.split(";");
        String originalName = null;

        // Loop through content-disposition parts to find filename
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                // Extract filename value (remove quotes)
                originalName = s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }

        if (originalName == null || originalName.isEmpty()) {
            originalName = "default.png";  // Fallback filename if none provided
        }

        // Preserve original extension or default to ".png"
        String extension = originalName.contains(".") ? originalName.substring(originalName.lastIndexOf(".")) : ".png";

        // Return a random UUID filename with extension to avoid collisions
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * Saves the uploaded image part to the specified folder inside /resources/images/.
     *
     * @param part       the uploaded file part
     * @param saveFolder the folder name inside resources/images where image will be saved
     * @param request    the HttpServletRequest to get real path context
     * @return filename of the saved image or null if saving failed
     */
    public String uploadImage(Part part, String saveFolder, HttpServletRequest request) {
        String savePath = request.getServletContext().getRealPath("/resources/images/" + saveFolder);
        File fileSaveDir = new File(savePath);

        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();  // Create directory if it doesn't exist
        }

        try {
            String imageName = getImageNameFromPart(part);  // Get sanitized file name
            String filePath = savePath + File.separator + imageName;
            part.write(filePath);  // Save file to disk
            return imageName;      // Return the saved filename
        } catch (IOException e) {
            e.printStackTrace();
            return null;           // Return null if saving failed
        }
    }

    /**
     * Returns absolute save path (useful for debugging or external use).
     *
     * @param saveFolder folder name inside images
     * @return full absolute path string on local disk
     */
    public String getSavePath(String saveFolder) {
        return "C:/Users/llll/eclipse-workspace/RadiantDreams/src/main/webapp/resources/images/" + saveFolder;
    }

    /**
     * Gets the relative web path to access an image for use in URLs.
     *
     * @param folder   image folder
     * @param filename image filename
     * @return relative path from web root
     */
    public String getImageWebPath(String folder, String filename) {
        return "/resources/images/" + folder + "/" + filename;
    }
}
