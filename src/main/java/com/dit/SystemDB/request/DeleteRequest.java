package com.dit.SystemDB.request;


import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DeleteRequest {

    @NotNull
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date timestamp;

    @NotNull
    private String source_ip;

    @NotNull
    private List<String> block_ids;

    public DeleteRequest() { }

    public DeleteRequest(@NotNull Date timestamp, @NotNull String source_ip, @NotNull List<String> block_ids) {
        this.timestamp = timestamp;
        this.source_ip = source_ip;
        this.block_ids = block_ids;
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

    public List<String> getBlock_ids() {
        return block_ids;
    }

    public void setBlock_ids(List<String> block_ids) {
        this.block_ids = block_ids;
    }
}
