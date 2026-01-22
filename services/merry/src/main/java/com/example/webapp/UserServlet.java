package com.example.webapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for handling user-related requests.
 * This class is not designed for extension.
 */
public final class UserServlet extends HttpServlet {
  /**
   * Handles GET requests for user information.
   *
   * @param request the HTTP request
   * @param response the HTTP response
   * @throws ServletException if servlet error occurs
   * @throws IOException if I/O error occurs
   */
  protected void doGet(final HttpServletRequest request,
      final HttpServletResponse response)
      throws ServletException, IOException {
    final String userId = request.getParameter("id");

    if (userId == null || userId.isEmpty()) {
      response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
      response.getWriter()
          .write("{\"error\":\"User ID is required\"}");
      return;
    }

    response.setContentType("application/json");
    response.getWriter()
        .write("{\"id\":\"" + userId
            + "\",\"name\":\"User " + userId + "\"}");
  }

  /**
   * Handles POST requests for creating users.
   *
   * @param request the HTTP request
   * @param response the HTTP response
   * @throws ServletException if servlet error occurs
   * @throws IOException if I/O error occurs
   */
  protected void doPost(final HttpServletRequest request,
      final HttpServletResponse response)
      throws ServletException, IOException {
    response.setStatus(HttpServletResponse.SC_CREATED);
    response.setContentType("application/json");
    response.getWriter()
        .write("{\"message\":\"User created successfully\"}");
  }
}