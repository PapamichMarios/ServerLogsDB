package com.dit.SystemDB.service;

import com.dit.SystemDB.model.*;
import com.dit.SystemDB.repository.LogRepository;
import com.dit.SystemDB.request.*;
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

    public ResponseEntity<?> insertReceived(Received hdfsDataRequest) {

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

    public ResponseEntity<?> insertReplicate(ReplicateRequest replicateRequest) {

        Log log = new Log(replicateRequest);
        HdfsLogs hdfs = new HdfsLogs();

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

        return ResponseEntity.ok(new ApiResponse(true, "Replicate type Log inserted successfully!"));
    }

    public ResponseEntity<?> insertDelete(DeleteRequest deleteRequest) {

        Log log = new Log(deleteRequest);
        HdfsLogs hdfs = new HdfsLogs();

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

        return ResponseEntity.ok(new ApiResponse(true, "Replicate type Log inserted successfully!"));
    }
}
