package com.dit.SystemDB.service;

import com.dit.SystemDB.exception.ResourceNotFoundException;
import com.dit.SystemDB.model.*;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.repository.QueryRepository;
import com.dit.SystemDB.repository.UserRepository;
import com.dit.SystemDB.request.*;
import com.dit.SystemDB.response.ApiResponse;
import com.dit.SystemDB.security.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LogService {

    @Autowired
    private LogRepository logRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private QueryRepository queryRepository;

    public ResponseEntity<?> insertAccess(AccessRequest accessRequest, UserDetailsImpl currentUser) {

        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        Log log = new Log(accessRequest);
        AccessLog access = new AccessLog(accessRequest);
        Query query = new Query(accessRequest);

        // set log
        log.setAccess_log(access);

        // set access log
        access.setLog(log);

        // save query for the user making it
        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        // save log and user queries
        logRepository.save(log);
        queryRepository.save(query);

        return ResponseEntity.ok(new ApiResponse(true, "Access type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertReceived(ReceivedRequest receivedRequest, UserDetailsImpl currentUser) {

        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        Log log = new Log(receivedRequest);
        HdfsLogs hdfs = new HdfsLogs(receivedRequest);
        Query query = new Query(receivedRequest);

        BlocksId blocksId = new BlocksId();
        blocksId.setBlock_id(receivedRequest.getBlock_id());
        Blocks blocks = new Blocks();
        blocks.setBlocksId(blocksId);
        blocks.setHdfsLogs(hdfs);

        List<Blocks> blocksList= new ArrayList<>();
        blocksList.add(blocks);
        hdfs.setBlocks(blocksList);

        DestinationsId destinationsId = new DestinationsId();
        destinationsId.setDestination(receivedRequest.getDestination_ip());
        Destinations destinations = new Destinations();
        destinations.setDestinationsId(destinationsId);
        destinations.setHdfsLogs(hdfs);

        List<Destinations> destinationsList = new ArrayList<>();
        destinationsList.add(destinations);
        hdfs.setDestinations(destinationsList);

        hdfs.setLog(log);
        log.setHdfsLogs(hdfs);

        logRepository.save(log);

        // save query for the user making it
        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        // save log and user queries
        queryRepository.save(query);

        return ResponseEntity.ok(new ApiResponse(true, "Received type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertReceiving(HdfsDataRequest hdfsDataRequest, UserDetailsImpl currentUser) {

        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        Log log = new Log(hdfsDataRequest, "receiving");
        HdfsLogs hdfs = new HdfsLogs();
        Query query = new Query(hdfsDataRequest, "RECEIVING");

        BlocksId blocksId = new BlocksId();
        blocksId.setBlock_id(hdfsDataRequest.getBlock_id());
        Blocks blocks = new Blocks();
        blocks.setBlocksId(blocksId);
        blocks.setHdfsLogs(hdfs);

        List<Blocks> blocksList= new ArrayList<>();
        blocksList.add(blocks);
        hdfs.setBlocks(blocksList);

        DestinationsId destinationsId = new DestinationsId();
        destinationsId.setDestination(hdfsDataRequest.getDestination_ip());
        Destinations destinations = new Destinations();
        destinations.setDestinationsId(destinationsId);
        destinations.setHdfsLogs(hdfs);

        List<Destinations> destinationsList = new ArrayList<>();
        destinationsList.add(destinations);
        hdfs.setDestinations(destinationsList);

        hdfs.setLog(log);
        log.setHdfsLogs(hdfs);

        logRepository.save(log);

        // save query for the user making it
        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        // save log and user queries
        queryRepository.save(query);

        return ResponseEntity.ok(new ApiResponse(true, "Receiving type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertServed(HdfsDataRequest hdfsDataRequest, UserDetailsImpl currentUser) {

        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        Log log = new Log(hdfsDataRequest, "served");
        HdfsLogs hdfs = new HdfsLogs();
        Query query = new Query(hdfsDataRequest, "SERVED");

        BlocksId blocksId = new BlocksId();
        blocksId.setBlock_id(hdfsDataRequest.getBlock_id());
        Blocks blocks = new Blocks();
        blocks.setBlocksId(blocksId);
        blocks.setHdfsLogs(hdfs);

        List<Blocks> blocksList= new ArrayList<>();
        blocksList.add(blocks);
        hdfs.setBlocks(blocksList);

        DestinationsId destinationsId = new DestinationsId();
        destinationsId.setDestination(hdfsDataRequest.getDestination_ip());
        Destinations destinations = new Destinations();
        destinations.setDestinationsId(destinationsId);
        destinations.setHdfsLogs(hdfs);

        List<Destinations> destinationsList = new ArrayList<>();
        destinationsList.add(destinations);
        hdfs.setDestinations(destinationsList);

        hdfs.setLog(log);
        log.setHdfsLogs(hdfs);

        logRepository.save(log);

        // save query for the user making it
        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        // save log and user queries
        queryRepository.save(query);

        return ResponseEntity.ok(new ApiResponse(true, "Served type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertReplicate(ReplicateRequest replicateRequest, UserDetailsImpl currentUser) {

        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        Log log = new Log(replicateRequest);
        HdfsLogs hdfs = new HdfsLogs();
        Query query = new Query(replicateRequest);

        BlocksId blocksId = new BlocksId();
        blocksId.setBlock_id(replicateRequest.getBlock_id());
        Blocks blocks = new Blocks();
        blocks.setBlocksId(blocksId);
        blocks.setHdfsLogs(hdfs);

        List<Blocks> blocksList= new ArrayList<>();
        blocksList.add(blocks);
        hdfs.setBlocks(blocksList);

        // replicate log has multiple destinations
        List<Destinations> destinationsList = new ArrayList<>();

        for (String dist : replicateRequest.getDestination_ips()) {

            //set references in destinations relation
            DestinationsId destinationsId = new DestinationsId();
            destinationsId.setDestination(dist);

            Destinations destinations = new Destinations();
            destinations.setDestinationsId(destinationsId);
            destinations.setHdfsLogs(hdfs);

            //add the object in list
            destinationsList.add(destinations);
        }

        hdfs.setDestinations(destinationsList);

        hdfs.setLog(log);
        log.setHdfsLogs(hdfs);

        logRepository.save(log);

        // save query for the user making it
        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        // save log and user queries
        queryRepository.save(query);

        return ResponseEntity.ok(new ApiResponse(true, "Replicate type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertDelete(DeleteRequest deleteRequest, UserDetailsImpl currentUser) {

        Long userId = currentUser.getId();

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        Log log = new Log(deleteRequest);
        HdfsLogs hdfs = new HdfsLogs();
        Query query = new Query(deleteRequest);

        // replicate log has multiple destinations
        List<Blocks> blocksList = new ArrayList<>();

        for (String block : deleteRequest.getBlock_ids()) {

            //set references in blocks relation
            BlocksId blocksId = new BlocksId();
            blocksId.setBlock_id(block);

            Blocks blocks = new Blocks();
            blocks.setBlocksId(blocksId);
            blocks.setHdfsLogs(hdfs);

            //add the object in list
            blocksList.add(blocks);
        }

        hdfs.setBlocks(blocksList);

        hdfs.setLog(log);
        log.setHdfsLogs(hdfs);

        logRepository.save(log);

        // save query for the user making it
        user.setQueries(Collections.singleton(query));
        query.setUsers(Collections.singleton(user));

        // save log and user queries
        queryRepository.save(query);

        return ResponseEntity.ok(new ApiResponse(true, "Delete type Log inserted successfully!"));
    }
}
