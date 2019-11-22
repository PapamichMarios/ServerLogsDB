package com.dit.SystemDB.request;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

public class ReplicateRequest {

    @NotNull
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date timestamp;

    @NotNull
    private String source_ip;

    @NotNull
    private String block_id;

    @NotNull
    private List<String> destination_ips;

    public ReplicateRequest() {
    }

    public ReplicateRequest(@NotNull Date timestamp, @NotNull String source_ip, @NotNull String block_id, @NotNull List<String> destination_ips) {
        this.timestamp = timestamp;
        this.source_ip = source_ip;
        this.block_id = block_id;
        this.destination_ips = destination_ips;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getSource_ip() {
        return source_ip;
    }

    public void setSource_ip(String source_ip) {
        this.source_ip = source_ip;
    }

    public String getBlock_id() {
        return block_id;
    }

    public void setBlock_id(String block_id) {
        this.block_id = block_id;
    }

    public List<String> getDestination_ips() {
        return destination_ips;
    }

    public void setDestination_ips(List<String> destination_ips) {
        this.destination_ips = destination_ips;
    }
}
