package com.dit.SystemDB.controller;


import com.dit.SystemDB.request.AccessRequest;
import com.dit.SystemDB.request.SignUpRequest;
import com.dit.SystemDB.service.LogService;
import org.eclipse.persistence.services.weblogic.MBeanWebLogicRuntimeServices;
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
    LogService logService;

    @PostMapping("/insertAccess")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> insertAccess(@Valid @RequestBody AccessRequest accessRequest) {

        return logService.insertAccess(accessRequest);
    }
}
