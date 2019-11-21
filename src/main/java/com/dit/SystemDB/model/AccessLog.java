package com.dit.SystemDB.model;

import javax.persistence.*;

@Entity
@Table(name="access_log")
public class AccessLog {

    @Id
    @Column(name="log_id")
    private Long id;

    @Column(name="user_id", length = 50)
    private String user_id;

    @Column(name="http_method", length = 20)
    private String http_method;

    @Column(columnDefinition = "TEXT",name="resource")
    private String resource;

    @Column(columnDefinition = "TEXT", name="http_response")
    private String http_response;

    @Column(name="size")
    private int size;

    @Column(columnDefinition = "TEXT", name="referer")
    private String referer;

    @Column(columnDefinition = "TEXT", name="user_agent")
    private String user_agent;

    // shared primary key with logs
    @OneToOne
    @MapsId
    @JoinColumn(name="log_id")
    private Log log;

    public AccessLog(Long id, String user_id, String http_method, String resource, String http_response, int size, String referer, String user_agent, Log log) {
        this.id = id;
        this.user_id = user_id;
        this.http_method = http_method;
        this.resource = resource;
        this.http_response = http_response;
        this.size = size;
        this.referer = referer;
        this.user_agent = user_agent;
        this.log = log;
    }

    public AccessLog() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getHttp_method() {
        return http_method;
    }

    public void setHttp_method(String http_method) {
        this.http_method = http_method;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getHttp_response() {
        return http_response;
    }

    public void setHttp_response(String http_response) {
        this.http_response = http_response;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getReferer() {
        return referer;
    }

    public void setReferer(String referer) {
        this.referer = referer;
    }

    public String getUser_agent() {
        return user_agent;
    }

    public void setUser_agent(String user_agent) {
        this.user_agent = user_agent;
    }

    public Log getLog() {
        return log;
    }

    public void setLog(Log log) {
        this.log = log;
    }
}
