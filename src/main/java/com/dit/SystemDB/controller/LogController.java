package com.dit.SystemDB.controller;


import com.dit.SystemDB.request.*;
import com.dit.SystemDB.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;
import java.util.concurrent.Delayed;

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
    public ResponseEntity<?> insertReceived(@Valid @RequestBody Received received) {

        return logService.insertReceived(received);
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

    @PostMapping("/insertReplicate")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertReplicate(@Valid @RequestBody ReplicateRequest replicateRequest) {

        return logService.insertReplicate(replicateRequest);
    }

    @PostMapping("/insertDelete")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertDelete(@Valid @RequestBody DeleteRequest deleteRequest) {

        return logService.insertDelete(deleteRequest);
    }
}
