package com.dit.SystemDB.controller;

import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.service.FunctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Date;

@Controller
public class FunctionController {

    @Autowired
    private FunctionService functionService;

    @GetMapping(path = "/function1")
    public ResponseEntity<?> getFunction1(@RequestParam("time1") @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date time1,
                                          @RequestParam("time2") @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date time2) {

        return functionService.getFunction1(time1, time2);
    }
}
