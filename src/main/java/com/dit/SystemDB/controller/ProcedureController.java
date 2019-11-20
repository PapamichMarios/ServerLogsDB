package com.dit.SystemDB.controller;

import com.dit.SystemDB.service.ProcedureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;

@Controller
public class ProcedureController {

    @Autowired
    private ProcedureService procedureService;

    @GetMapping(path = "/procedure1")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> getProcedure1(@RequestParam("from") @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date from,
                                          @RequestParam("to")   @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date to) {

        return procedureService.getProcedure1(from, to);
    }
}
