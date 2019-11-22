package com.dit.SystemDB.service;

import com.dit.SystemDB.model.AccessLog;
import com.dit.SystemDB.model.Log;
import com.dit.SystemDB.repository.AccessRepository;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.request.AccessRequest;
import com.dit.SystemDB.response.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.awt.*;

@Service
public class LogService {

    @Autowired
    LogService logService;

    @Autowired
    LogRepository logRepository;

    @Autowired
    AccessRepository accessRepository;

    public ResponseEntity<?> insertAccess(AccessRequest accessRequest) {

        Log log = new Log(accessRequest);
        AccessLog access = new AccessLog(accessRequest);

        // set log
        log.setAccess_log(access);

        // set access log
        access.setLog(log);

        // save both
        logRepository.save(log);

        return ResponseEntity.ok(new ApiResponse(true, "Access Log inserted successfully!"));
    }
}
