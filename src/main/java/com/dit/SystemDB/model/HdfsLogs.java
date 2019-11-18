package com.dit.SystemDB.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table
public class HdfsLogs {

    @Id
    @Column(name="log_id")
    private Long id;

    @Column(name="size")
    private int size;

    // shared pk with log
    @OneToOne
    @MapsId
    @JoinColumn(name="log_id")
    private Log log;

    // pk is fk to blocks
    @OneToMany(mappedBy = "hdfsLogs", cascade = CascadeType.ALL)
    private List<Blocks> blocks;

    @OneToMany(mappedBy = "hdfsLogs", cascade = CascadeType.ALL)
    private List<Destinations> destinations;

    public HdfsLogs(Long id, int size, Log log, List<Blocks> blocks, List<Destinations> destinations) {
        this.id = id;
        this.size = size;
        this.log = log;
        this.blocks = blocks;
        this.destinations = destinations;
    }

    public HdfsLogs() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public Log getLog() {
        return log;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    public List<Blocks> getBlocks() {
        return blocks;
    }

    public void setBlocks(List<Blocks> blocks) {
        this.blocks = blocks;
    }

    public List<Destinations> getDestinations() {
        return destinations;
    }

    public void setDestinations(List<Destinations> destinations) {
        this.destinations = destinations;
    }
}
