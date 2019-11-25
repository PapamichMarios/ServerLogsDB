package com.dit.SystemDB.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class BlocksId implements Serializable {

    @Column(name="log_id", nullable = false)
    private Long log_id;

    @Column(name="block_id", nullable = false)
    private String block_id;

    public BlocksId() {
    }

    public BlocksId(Long log_id, String block_id) {
        this.log_id = log_id;
        this.block_id = block_id;
    }

    public Long getLog_id() {
        return log_id;
    }

    public void setLog_id(Long log_id) {
        this.log_id = log_id;
    }

    public String getBlock_id() {
        return block_id;
    }

    public void setBlock_id(String block_id) {
        this.block_id = block_id;
    }
}
