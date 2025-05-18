package com.RadiantDreams.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HTTP sessions in the RadiantDreams web application.
 */
public class SessionUtil {

    /**
     * Stores a value in the session under the specified key.
     *
     * @param request HttpServletRequest object
     * @param key     the attribute key
     * @param value   the value to store
     */
	public static void setAttribute(HttpServletRequest request, String key, Object value) {
	    HttpSession session = request.getSession();
	    session.setMaxInactiveInterval(300); // Set session timeout to 300 seconds (5 minutes)
	    session.setAttribute(key, value);
	}


    /**
     * Retrieves a value from the session.
     *
     * @param request HttpServletRequest object
     * @param key     the key of the attribute
     * @return the value stored in session or null if not found
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        return (session != null) ? session.getAttribute(key) : null;
    }

    /**
     * Removes a value from the session.
     *
     * @param request HttpServletRequest object
     * @param key     the key of the attribute to remove
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidates the current session.
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