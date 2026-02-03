package com.example.webapp;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.Before;
import org.junit.Test;

/**
 * Unit tests for ProductServlet.
 */
public final class ProductServletTest {

    private ProductServlet servlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private StringWriter stringWriter;
    private PrintWriter writer;

    /**
     * Setup test fixtures before each test.
     *
     * @throws Exception if setup fails
     */
    @Before
    public void setUp() throws Exception {
        servlet = new ProductServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        stringWriter = new StringWriter();
        writer = new PrintWriter(stringWriter);
        when(response.getWriter()).thenReturn(writer);
    }

    /**
     * Test GET request without category parameter.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetWithoutCategory() throws Exception {
        when(request.getParameter("category")).thenReturn(null);

        servlet.doGet(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"products\":[\"Product1\",\"Product2\"]}",
                result);
        verify(response).setContentType("application/json");
    }

    /**
     * Test GET request with category parameter.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetWithCategory() throws Exception {
        when(request.getParameter("category"))
                .thenReturn("electronics");

        servlet.doGet(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"category\":\"electronics\",\"products\":[]}",
                result);
        verify(response).setContentType("application/json");
    }

    /**
     * Test DELETE request with valid product ID.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoDeleteWithValidId() throws Exception {
        when(request.getParameter("id")).thenReturn("456");

        servlet.doDelete(request, response);

        verify(response)
                .setStatus(HttpServletResponse.SC_NO_CONTENT);
    }

    /**
     * Test DELETE request without product ID.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoDeleteWithoutId() throws Exception {
        when(request.getParameter("id")).thenReturn(null);

        servlet.doDelete(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"error\":\"Product ID is required\"}", result);
        verify(response)
                .setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }

    /**
     * Test DELETE request with empty product ID.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoDeleteWithEmptyId() throws Exception {
        when(request.getParameter("id")).thenReturn("");

        servlet.doDelete(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"error\":\"Product ID is required\"}", result);
        verify(response)
                .setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }
}