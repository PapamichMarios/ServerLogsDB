package com.dit.SystemDB.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class DestinationsId implements Serializable {

    @Column(name="log_id")
    private Long lod_id;

    @Column(name="destination")
    private String destination;

    public DestinationsId() {
    }

    public Long getLod_id() {
        return lod_id;
    }

    public void setLod_id(Long lod_id) {
        this.lod_id = lod_id;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }
}
