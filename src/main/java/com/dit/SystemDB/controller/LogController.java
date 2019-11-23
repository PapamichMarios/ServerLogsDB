package com.dit.SystemDB.controller;


import com.dit.SystemDB.request.*;
import com.dit.SystemDB.security.CurrentUser;
import com.dit.SystemDB.security.UserDetailsImpl;
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
    public ResponseEntity<?> insertAccess(@Valid @RequestBody AccessRequest accessRequest,
                                          @Valid @CurrentUser UserDetailsImpl currentUser) {

        return logService.insertAccess(accessRequest, currentUser);
    }

    @PostMapping("/insertReceived")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertReceived(@Valid @RequestBody ReceivedRequest receivedRequest,
                                            @Valid @CurrentUser UserDetailsImpl currentUser) {

        return logService.insertReceived(receivedRequest, currentUser);
    }

    @PostMapping("/insertReceiving")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertReceiving(@Valid @RequestBody HdfsDataRequest hdfsDataRequest,
                                             @Valid @CurrentUser UserDetailsImpl currentUser) {

        return logService.insertReceiving(hdfsDataRequest, currentUser);
    }

    @PostMapping("/insertServed")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertServed(@Valid @RequestBody HdfsDataRequest hdfsDataRequest,
                                          @Valid @CurrentUser UserDetailsImpl currentUser) {

        return logService.insertServed(hdfsDataRequest, currentUser);
    }

    @PostMapping("/insertReplicate")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertReplicate(@Valid @RequestBody ReplicateRequest replicateRequest,
                                             @Valid @CurrentUser UserDetailsImpl currentUser) {

        return logService.insertReplicate(replicateRequest, currentUser);
    }

    @PostMapping("/insertDelete")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertDelete(@Valid @RequestBody DeleteRequest deleteRequest,
                                          @Valid @CurrentUser UserDetailsImpl currentUser) {

        return logService.insertDelete(deleteRequest, currentUser);
    }
}
