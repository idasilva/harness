
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
 * Unit tests for UserServlet.
 */
public final class UserServletTest {

    private UserServlet servlet;
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
        servlet = new UserServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        stringWriter = new StringWriter();
        writer = new PrintWriter(stringWriter);
        when(response.getWriter()).thenReturn(writer);
    }

    /**
     * Test GET request with valid user ID.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetWithValidUserId() throws Exception {
        when(request.getParameter("id")).thenReturn("123");
        
        servlet.doGet(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"id\":\"123\",\"name\":\"User 123\"}", result);
        verify(response).setContentType("application/json");
    }

    /**
     * Test GET request without user ID.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetWithoutUserId() throws Exception {
        when(request.getParameter("id")).thenReturn(null);
        
        servlet.doGet(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"error\":\"User ID is required\"}", result);
        verify(response)
            .setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }

    /**
     * Test GET request with empty user ID.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetWithEmptyUserId() throws Exception {
        when(request.getParameter("id")).thenReturn("");
        
        servlet.doGet(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"error\":\"User ID is required\"}", result);
        verify(response)
            .setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }

    /**
     * Test POST request for creating user.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoPostCreatesUser() throws Exception {
        servlet.doPost(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"message\":\"User created successfully\"}",
            result);
        verify(response).setStatus(HttpServletResponse.SC_CREATED);
        verify(response).setContentType("application/json");
    }
}