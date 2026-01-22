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
 * Unit tests for HealthCheckServlet.
 */
public final class HealthCheckServletTest {

    private HealthCheckServlet servlet;
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
        servlet = new HealthCheckServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        stringWriter = new StringWriter();
        writer = new PrintWriter(stringWriter);
        when(response.getWriter()).thenReturn(writer);
    }

    /**
     * Test health check returns healthy status.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testHealthCheckReturnsHealthyStatus() throws Exception {
        servlet.doGet(request, response);
        writer.flush();

        final String result = stringWriter.toString();
        assertEquals("{\"status\":\"healthy\",\"service\":\"merry\"}",
            result);
        verify(response).setStatus(HttpServletResponse.SC_OK);
        verify(response).setContentType("application/json");
    }

    /**
     * Test health check sets correct content type.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testHealthCheckSetsJsonContentType() throws Exception {
        servlet.doGet(request, response);
        verify(response).setContentType("application/json");
    }
}