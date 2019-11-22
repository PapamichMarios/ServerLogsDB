package com.dit.SystemDB.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class DestinationsId implements Serializable {

    @Column(name="log_id")
    private Long log_id;

    @Column(name="destination")
    private String destination;

    public DestinationsId() {
    }

    public DestinationsId(Long lod_id, String destination) {
        this.log_id = lod_id;
        this.destination = destination;
    }

    public Long getLod_id() {
        return log_id;
    }

    public void setLod_id(Long lod_id) {
        this.log_id = lod_id;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }
}
