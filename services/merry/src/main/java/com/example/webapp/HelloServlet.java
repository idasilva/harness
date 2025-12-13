package com.example.webapp;

import java.io.IOException;
import jakarta.servlet.ServletException;  // ✅ Changed from javax
import jakarta.servlet.http.HttpServlet;  // ✅ Changed from javax
import jakarta.servlet.http.HttpServletRequest;  // ✅ Changed from javax
import jakarta.servlet.http.HttpServletResponse;  // ✅ Changed from javax

public class HelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().write("<h1>Hello, Jenkins with WAR!</h1>");
    }
}