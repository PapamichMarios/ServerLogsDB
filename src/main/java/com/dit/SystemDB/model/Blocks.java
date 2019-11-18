package com.dit.SystemDB.model;

import javax.persistence.*;

@Entity
@Table(name="blocks")
public class Blocks {

    @EmbeddedId
    private BlocksId blocksId;

    // shared pk with hdfs logs
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId(value = "log_id")
    @JoinColumn(name = "log_id")
    private HdfsLogs hdfsLogs;

    public Blocks(BlocksId blocksId, HdfsLogs hdfsLogs) {
        this.blocksId = blocksId;
        this.hdfsLogs = hdfsLogs;
    }

    public Blocks() { }

    public BlocksId getBlocksId() {
        return blocksId;
    }

    public void setBlocksId(BlocksId blocksId) {
        this.blocksId = blocksId;
    }

    public HdfsLogs getHdfsLogs() {
        return hdfsLogs;
    }

    public void setHdfsLogs(HdfsLogs hdfsLogs) {
        this.hdfsLogs = hdfsLogs;
    }
}
