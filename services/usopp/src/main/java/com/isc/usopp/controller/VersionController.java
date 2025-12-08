package com.isc.usopp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * REST controller for version information.
 */
@RestController
@RequestMapping("/java/v1")
public final class VersionController {

    /**
     * Returns the version of the application.
     *
     * @return version string
     */
    @GetMapping("/version")
    public String getVersion() {
        return "v1.0.1";
    }
}

