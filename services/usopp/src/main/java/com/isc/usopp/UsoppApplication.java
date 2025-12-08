package com.isc.usopp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Main Spring Boot application class for Usopp service.
 */
@SpringBootApplication
public class UsoppApplication {

    /**
     * Private constructor to prevent instantiation.
     */
    private UsoppApplication() {
        // Utility class
    }

    /**
     * Main method to run the Spring Boot application.
     *
     * @param args command line arguments
     */
    public static void main(final String[] args) {
        SpringApplication.run(UsoppApplication.class, args);
    }

}
