package com.dit.SystemDB.service;

import com.dit.SystemDB.model.*;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.request.AccessRequest;
import com.dit.SystemDB.request.HdfsDataRequest;
import com.dit.SystemDB.request.HdfsDataRequestWithSize;
import com.dit.SystemDB.response.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class LogService {

    @Autowired
    private LogRepository logRepository;

    public ResponseEntity<?> insertAccess(AccessRequest accessRequest) {

        Log log = new Log(accessRequest);
        AccessLog access = new AccessLog(accessRequest);

        // set log
        log.setAccess_log(access);

        // set access log
        access.setLog(log);

        // save both
        logRepository.save(log);

        return ResponseEntity.ok(new ApiResponse(true, "Access type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertReceived(HdfsDataRequestWithSize hdfsDataRequest) {

        Log log = new Log(hdfsDataRequest);
        HdfsLogs hdfs = new HdfsLogs(hdfsDataRequest);

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

        return ResponseEntity.ok(new ApiResponse(true, "Received type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertReceiving(HdfsDataRequest hdfsDataRequest) {

        Log log = new Log(hdfsDataRequest, "receiving");
        HdfsLogs hdfs = new HdfsLogs();

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

        return ResponseEntity.ok(new ApiResponse(true, "Receiving type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertServed(HdfsDataRequest hdfsDataRequest) {

        Log log = new Log(hdfsDataRequest, "served");
        HdfsLogs hdfs = new HdfsLogs();

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

        return ResponseEntity.ok(new ApiResponse(true, "Served type Log inserted successfully!"));
    }
}
