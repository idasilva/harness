package com.isc.usopp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/java/v1")
public class VersionController {

    @GetMapping("/version")
    public String getVersion() {
        return "v1.0.0";
    }
}
