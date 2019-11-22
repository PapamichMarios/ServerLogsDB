package com.dit.SystemDB.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import java.util.Date;

public class Received {

    @NotNull
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date timestamp;

    @NotNull
    private String source_ip;

    @NotNull
    private String block_id;

    @NotNull
    private int size;

    @NotNull
    private String destination_ip;

    public Received() { }

    public Received(@NotNull Date timestamp, @NotNull String source_ip, @NotNull String block_id, @NotNull int size, @NotNull String destination_ip) {
        this.timestamp = timestamp;
        this.source_ip = source_ip;
        this.block_id = block_id;
        this.size = size;
        this.destination_ip = destination_ip;
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

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getDestination_ip() {
        return destination_ip;
    }

    public void setDestination_ip(String destination_ip) {
        this.destination_ip = destination_ip;
    }
}
