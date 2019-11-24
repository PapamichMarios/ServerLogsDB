package com.dit.SystemDB.service;

import com.dit.SystemDB.exception.ResourceNotFoundException;
import com.dit.SystemDB.model.Query;
import com.dit.SystemDB.model.User;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.repository.QueryRepository;
import com.dit.SystemDB.repository.UserRepository;
import com.dit.SystemDB.security.UserDetailsImpl;
import com.dit.SystemDB.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
public class ProcedureService {

    @Autowired
    private LogRepository logRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private QueryRepository queryRepository;

    public ResponseEntity<?> getProcedure1(Date from, Date to, UserDetailsImpl currentUser) {

        //check the user issuing
        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        // find all the logs for function1
        List<Object[]> result = logRepository.function1(from, to);

        // save the action to query table
        Query query = new Query(from, to);

        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        queryRepository.save(query);

        if (result == null) {
            return ResponseEntity.ok(new Procedure1Response());
        }

        return ResponseEntity.ok(new Procedure1Response(result));
    }

    public ResponseEntity<?> getProcedure2(Date from, Date to, String type, UserDetailsImpl currentUser) {

        //check the user issuing
        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        // find all the logs for function2
        List<Object[]> result = logRepository.function2(from, to, type);

        // save the action to query table
        Query query = new Query(from, to, type);

        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        queryRepository.save(query);

        if (result == null) {
            return ResponseEntity.ok(new Procedure2Response());
        }

        return ResponseEntity.ok(new Procedure2Response(result));
    }

    public ResponseEntity<?> getProcedure3(Date day, UserDetailsImpl currentUser) {

        //check the user issuing
        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        // find all the logs for function3
        List<Object[]> result = logRepository.function3(day);

        // save the action to query table
        Query query = new Query(day);

        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        queryRepository.save(query);

        if (result == null) {
            return ResponseEntity.ok(new Procedure3Response());
        }

        return ResponseEntity.ok(new Procedure3Response(result));
    }

    public ResponseEntity<?> getSource(String ip, UserDetailsImpl currentUser) {

        //check the user issuing
        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        // find all logs with source ip = ip
        List<Object[]> result = logRepository.source(ip);

        // save the action to query table
        Query query = new Query(ip, "SOURCE_IP");

        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        queryRepository.save(query);

        if (result == null) {
            return ResponseEntity.ok(new SourceResponse());
        }

        return ResponseEntity.ok(new SourceResponse(result));
    }

    public ResponseEntity<?> getDest(String ip, UserDetailsImpl currentUser) {

        //check the user issuing
        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        // find all logs with source ip = ip
        List<Object[]> result = logRepository.dest(ip);

        // save the action to query table
        Query query = new Query(ip, "DESTINATION_IP");

        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        queryRepository.save(query);

        if (result == null) {
            return ResponseEntity.ok(new DestResponse());
        }

        return ResponseEntity.ok(new DestResponse(result));
    }
}
