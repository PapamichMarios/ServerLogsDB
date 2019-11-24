package com.dit.SystemDB.controller;

import com.dit.SystemDB.security.CurrentUser;
import com.dit.SystemDB.security.UserDetailsImpl;
import com.dit.SystemDB.service.ProcedureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Date;

@Controller
public class ProcedureController {

    @Autowired
    private ProcedureService procedureService;

    @GetMapping(path = "/executeProcedure1")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> getProcedure1(@RequestParam("from") @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date from,
                                           @RequestParam("to")   @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date to,
                                           @Valid @CurrentUser UserDetailsImpl currentUser) {

        return procedureService.getProcedure1(from, to, currentUser);
    }

    @GetMapping(path = "/executeProcedure2")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> getProcedure2(@RequestParam("from") @DateTimeFormat(pattern="yyyy-MM-dd") Date from,
                                           @RequestParam("to")   @DateTimeFormat(pattern="yyyy-MM-dd") Date to,
                                           @RequestParam("type") String type,
                                           @Valid @CurrentUser UserDetailsImpl currentUser) {

        return procedureService.getProcedure2(from, to, type, currentUser);
    }

    @GetMapping(path = "/executeProcedure3")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> getProcedure3(@RequestParam("day") @DateTimeFormat(pattern="yyyy-MM-dd") Date day,
                                           @Valid @CurrentUser UserDetailsImpl currentUser) {

        return procedureService.getProcedure3(day, currentUser);
    }
}
