package com.dit.SystemDB.model;

import com.dit.SystemDB.request.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="logs")
public class Log {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "log_id")
    private Long id;

    @Column(name = "source_ip", nullable = false, length = 50)
    private String source_ip;

    @Column(name = "log_timestamp", nullable = false)
    @DateTimeFormat(pattern="yyyy-MM-dd hh-MM-ss")
    private Date log_timestamp;

    @Column(name="type", nullable = false, length = 20)
    private String type;

    // shared primary keys
    @OneToOne(mappedBy = "log", cascade = CascadeType.ALL)
    private AccessLog access_log;

    @OneToOne(mappedBy = "log", cascade = CascadeType.ALL)
    private HdfsLogs hdfsLogs;

    public Log() { }

    public Log(Long id, String source_ip, Date log_timestamp, String type, AccessLog access_log, HdfsLogs hdfsLogs) {
        this.id = id;
        this.source_ip = source_ip;
        this.log_timestamp = log_timestamp;
        this.type = type;
        this.access_log = access_log;
        this.hdfsLogs = hdfsLogs;
    }

    public Log(AccessRequest accessRequest) {
        this.source_ip = accessRequest.getSource_ip();
        this.log_timestamp = accessRequest.getTimestamp();
        this.type = "access";
    }

    public Log(HdfsDataRequest hdfsDataRequest, String type) {
        this.source_ip = hdfsDataRequest.getSource_ip();
        this.log_timestamp = hdfsDataRequest.getTimestamp();
        this.type = type;
    }

    public Log(Received hdfsDataRequest) {
        this.source_ip = hdfsDataRequest.getSource_ip();
        this.log_timestamp = hdfsDataRequest.getTimestamp();
        this.type = "received";
    }

    public Log(ReplicateRequest replicateRequest) {
        this.source_ip = replicateRequest.getSource_ip();
        this.log_timestamp = replicateRequest.getTimestamp();
        this.type = "replicate";
    }

    public Log(DeleteRequest deleteRequest) {
        this.source_ip = deleteRequest.getSource_ip();
        this.log_timestamp = deleteRequest.getTimestamp();
        this.type = "delete";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSource_ip() {
        return source_ip;
    }

    public void setSource_ip(String source_ip) {
        this.source_ip = source_ip;
    }

    public Date getLog_timestamp() {
        return log_timestamp;
    }

    public void setLog_timestamp(Date log_timestamp) {
        this.log_timestamp = log_timestamp;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public AccessLog getAccess_log() {
        return access_log;
    }

    public void setAccess_log(AccessLog access_log) {
        this.access_log = access_log;
    }

    public HdfsLogs getHdfsLogs() {
        return hdfsLogs;
    }

    public void setHdfsLogs(HdfsLogs hdfsLogs) {
        this.hdfsLogs = hdfsLogs;
    }
}
