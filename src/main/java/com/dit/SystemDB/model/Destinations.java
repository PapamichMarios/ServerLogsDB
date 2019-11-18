package com.dit.SystemDB.model;

import javax.persistence.*;

@Entity
@Table(name="destinations")
public class Destinations {

    @EmbeddedId
    private DestinationsId destinationsId;

    // shared pk with hdfs logs
    @ManyToOne
    @MapsId(value = "log_id")
    @JoinColumn(name="log_id")
    private HdfsLogs hdfsLogs;

    public Destinations(DestinationsId destinationsId, HdfsLogs hdfsLogs) {
        this.destinationsId = destinationsId;
        this.hdfsLogs = hdfsLogs;
    }

    public Destinations() {
    }

    public DestinationsId getDestinationsId() {
        return destinationsId;
    }

    public void setDestinationsId(DestinationsId destinationsId) {
        this.destinationsId = destinationsId;
    }

    public HdfsLogs getHdfsLogs() {
        return hdfsLogs;
    }

    public void setHdfsLogs(HdfsLogs hdfsLogs) {
        this.hdfsLogs = hdfsLogs;
    }
}
