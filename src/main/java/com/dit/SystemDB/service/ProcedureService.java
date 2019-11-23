package com.dit.SystemDB.service;

import com.dit.SystemDB.model.Log;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.response.Procedure1Response;
import com.dit.SystemDB.response.Procedure2Response;
import com.dit.SystemDB.response.Procedure3Response;
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

    public ResponseEntity<?> getProcedure2(Date from, Date to, String type) {

        // find all the logs for function2
        List<Object[]> result = logRepository.function2(from, to, type);

        if (result == null) {
            return ResponseEntity.ok(new Procedure2Response());
        }

        return ResponseEntity.ok(new Procedure2Response(result));
    }

    public ResponseEntity<?> getProcedure3(Date day) {

        // find all the logs for function3
        List<Object[]> result = logRepository.function3(day);

        if (result == null) {
            return ResponseEntity.ok(new Procedure3Response());
        }

        return ResponseEntity.ok(new Procedure3Response(result));
    }
}
