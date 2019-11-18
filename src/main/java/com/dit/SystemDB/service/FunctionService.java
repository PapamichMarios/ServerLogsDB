package com.dit.SystemDB.service;

import com.dit.SystemDB.model.Log;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.response.Function1Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class FunctionService {

    @Autowired
    private LogRepository logRepository;

    public ResponseEntity<?> getFunction1(Date time1, Date time2) {

        // find all the logs for function1
        List<Log> logs = logRepository.function1(time1, time2);

        if (logs == null) {
            return ResponseEntity.ok(new Function1Response<Log>());
        }

        return ResponseEntity.ok(new Function1Response<Log>(logs));
    }
}
