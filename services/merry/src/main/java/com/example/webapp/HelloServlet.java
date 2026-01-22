package com.example.webapp;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Simple servlet that returns a hello message.
 * This class is not designed for extension.
 */
public final class HelloServlet extends HttpServlet {
    /**
     * Handles GET requests.
     *
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    protected void doGet(final HttpServletRequest request,
                         final HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter()
            .write("<h1>Hello, Jenkins with WAR!</h1>");
    }
}