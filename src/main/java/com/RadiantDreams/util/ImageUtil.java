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
     * If not found, assigns a random filename.
     */
    public String getImageNameFromPart(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        String originalName = null;

        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                originalName = s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }

        if (originalName == null || originalName.isEmpty()) {
            originalName = "default.png";
        }

        // Generate random UUID-based filename
        String extension = originalName.contains(".") ? originalName.substring(originalName.lastIndexOf(".")) : ".png";
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * Saves the uploaded image part to the specified folder inside /resources/images/.
     * Returns the filename of the saved image or null if failed.
     */
    public String uploadImage(Part part, String saveFolder, HttpServletRequest request) {
        String savePath = request.getServletContext().getRealPath("/resources/images/" + saveFolder);
        File fileSaveDir = new File(savePath);

        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        try {
            String imageName = getImageNameFromPart(part);
            String filePath = savePath + File.separator + imageName;
            part.write(filePath);
            return imageName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }


    public String getSavePath(String saveFolder) {
        return "C:/Users/llll/eclipse-workspace/RadiantDreams/src/main/webapp/resources/images/" + saveFolder;
    }
    
    /**
     * Gets the web-accessible relative path for an image
     */
    public String getImageWebPath(String folder, String filename) {
        return "/resources/images/" + folder + "/" + filename;
    }
}