package com.example.webapp;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet for handling product-related requests.
 * This class is not designed for extension.
 */
public final class ProductServlet extends HttpServlet {
    /**
     * Handles GET requests for product listing.
     *
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    protected void doGet(final HttpServletRequest request,
                         final HttpServletResponse response)
            throws ServletException, IOException {
        final String category = request.getParameter("category");
        
        response.setContentType("application/json");
        
        if (category != null && !category.isEmpty()) {
            response.getWriter()
                .write("{\"category\":\"" + category 
                    + "\",\"products\":[]}");
        } else {
            response.getWriter()
                .write("{\"products\":[\"Product1\",\"Product2\"]}");
        }
    }

    /**
     * Handles DELETE requests for removing products.
     *
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    protected void doDelete(final HttpServletRequest request,
                            final HttpServletResponse response)
            throws ServletException, IOException {
        final String productId = request.getParameter("id");
        
        if (productId == null || productId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter()
                .write("{\"error\":\"Product ID is required\"}");
            return;
        }
        
        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}