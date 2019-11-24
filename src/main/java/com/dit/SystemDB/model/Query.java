package com.dit.SystemDB.model;

import com.dit.SystemDB.request.*;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name="queries")
public class Query {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "query_id")
    private Long id;


    @Column(columnDefinition = "TEXT", name="log")
    private String log;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "user_queries",
            joinColumns = @JoinColumn(name = "query_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
    private Set<User> users  = new HashSet<>();

    public Query(Date from, Date to, String type) {
        this.log = "Performed PROCEDURE_2 "
                + "from: " + from
                + "to: " + to
                + "type: " + type;
    }

    public Query(Date from, Date to) {
        this.log = "Performed PROCEDURE_1 "
                + "from: " + from
                + "to: " + to;
    }

    public Query(Date day) {
        this.log = "Performed PROCEDURE_3 "
                + "day: " + day;
    }

    public Query(String ip, String type) {
        this.log = "Searched " + type + ": " + ip;
    }

    public Query(AccessRequest accessRequest) {
        this.log = "Inserted log of type ACCESS "
                + accessRequest.getTimestamp() + ' '
                + accessRequest.getSource_ip() + ' '
                + accessRequest.getHttp_method() + ' '
                + accessRequest.getReferer() + ' '
                + accessRequest.getResource() + ' '
                + accessRequest.getUser_agent();
    }

    public Query(ReceivedRequest receivedRequest) {
        this.log = "Inserted log of type RECEIVED "
                + receivedRequest.getTimestamp() + ' '
                + receivedRequest.getSource_ip() + ' '
                + receivedRequest.getDestination_ip() + ' '
                + receivedRequest.getBlock_id() + ' '
                + receivedRequest.getSize();
    }

    public Query(HdfsDataRequest hdfsDataRequest, String type) {
        this.log = "Inserted log of type " + type +  ' '
                + hdfsDataRequest.getTimestamp() + ' '
                + hdfsDataRequest.getSource_ip() + ' '
                + hdfsDataRequest.getBlock_id() + ' '
                + hdfsDataRequest.getDestination_ip();
    }

    public Query(ReplicateRequest replicateRequest) {
        this.log = "Inserted log of type REPLICATE "
                + replicateRequest.getTimestamp() + ' '
                + replicateRequest.getSource_ip() + ' '
                + replicateRequest.getBlock_id() + ' '
                + "List<DestinationIPs>";
    }

    public Query(DeleteRequest deleteRequest) {
        this.log = "Inserted log of type DELETE "
                + deleteRequest.getTimestamp() + ' '
                + deleteRequest.getSource_ip() + ' '
                + "List<BlockIDs>";
    }

    public Query(Long id, String log, Set<User> users) {
        this.id = id;
        this.log = log;
        this.users = users;
    }

    public Query() { }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }
}
