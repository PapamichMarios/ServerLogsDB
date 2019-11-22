package com.dit.SystemDB.controller;


import com.dit.SystemDB.request.AccessRequest;
import com.dit.SystemDB.request.HdfsDataRequest;
import com.dit.SystemDB.request.HdfsDataRequestWithSize;
import com.dit.SystemDB.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@Controller
public class LogController {

    @Autowired
    private LogService logService;

    @PostMapping("/insertAccess")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertAccess(@Valid @RequestBody AccessRequest accessRequest) {

        return logService.insertAccess(accessRequest);
    }

    @PostMapping("/insertReceived")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertReceived(@Valid @RequestBody HdfsDataRequestWithSize hdfsDataRequestWithSize) {

        return logService.insertReceived(hdfsDataRequestWithSize);
    }

    @PostMapping("/insertReceiving")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertReceiving(@Valid @RequestBody HdfsDataRequest hdfsDataRequest) {

        return logService.insertReceiving(hdfsDataRequest);
    }

    @PostMapping("/insertServed")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertServed(@Valid @RequestBody HdfsDataRequest hdfsDataRequest) {

        return logService.insertServed(hdfsDataRequest);
    }
}
