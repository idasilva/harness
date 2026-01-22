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

import com.example.webapp.HelloServlet;

/**
 * Unit tests for HelloServlet.
 */
public final class HelloServletTest {

    private HelloServlet servlet;
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
        servlet = new HelloServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        stringWriter = new StringWriter();
        writer = new PrintWriter(stringWriter);
        when(response.getWriter()).thenReturn(writer);
    }

    /**
     * Test that doGet writes the expected message.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetWritesHelloMessage() throws Exception {
        servlet.doGet(request, response);
        writer.flush();

        String result = stringWriter.toString();
        assertEquals("<h1>Hello, Jenkins with WAR!</h1>", result);
    }

    /**
     * Test that doGet calls getWriter on response.
     *
     * @throws Exception if test fails
     */
    @Test
    public void testDoGetCallsGetWriter() throws Exception {
        servlet.doGet(request, response);
        verify(response).getWriter();
    }
}