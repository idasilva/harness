package com.example.webapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for health check endpoint.
 * This class is not designed for extension.
 */
public final class HealthCheckServlet extends HttpServlet {
  /**
   * Handles GET requests for health check.
   *
   * @param request the HTTP request
   * @param response the HTTP response
   * @throws ServletException if servlet error occurs
   * @throws IOException if I/O error occurs
   */
  protected void doGet(final HttpServletRequest request,
      final HttpServletResponse response)
      throws ServletException, IOException {
    response.setStatus(HttpServletResponse.SC_OK);
    response.setContentType("application/json");
    response.getWriter()
        .write("{\"status\":\"healthy\",\"service\":\"merry\"}");
  }
}