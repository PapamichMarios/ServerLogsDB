package com.dit.SystemDB.service;

import com.dit.SystemDB.model.Log;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.response.Procedure1Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ProcedureService {

    @Autowired
    private LogRepository logRepository;

    public ResponseEntity<?> getProcedure1(Date from, Date to) {

        // find all the logs for function1
        List<Object[]> result = logRepository.function1(from, to);

        if (result == null) {
            return ResponseEntity.ok(new Procedure1Response());
        }

        return ResponseEntity.ok(new Procedure1Response(result));
    }
}
