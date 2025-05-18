package com.RadiantDreams.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HTTP sessions in the RadiantDreams web application.
 */
public class SessionUtil {

    /**
     * Stores a value in the session under the specified key.
     * Sets the session timeout to 5 minutes (300 seconds).
     *
     * @param request HttpServletRequest object
     * @param key     the attribute key to store
     * @param value   the value to store in session
     */
    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(300); // 5 minutes timeout
        session.setAttribute(key, value);
    }

    /**
     * Retrieves a value from the session by key.
     *
     * @param request HttpServletRequest object
     * @param key     the attribute key to retrieve
     * @return the value stored in session or null if none exists
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);  // false = don't create session if not exist
        return (session != null) ? session.getAttribute(key) : null;
    }

    /**
     * Removes a value from the session by key.
     *
     * @param request HttpServletRequest object
     * @param key     the attribute key to remove
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidates the current session, logging the user out.
     *
     * @param request HttpServletRequest object
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
