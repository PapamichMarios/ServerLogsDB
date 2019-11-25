package com.dit.SystemDB.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

public class AccessRequest {

    @NotNull
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date timestamp;

    @NotNull
    private String source_ip;

    @NotNull
    private String http_method;

    @NotNull
    private String http_response;

    private String referer;

    @NotNull
    private String resource;

    @NotNull
    private Long size;

    private String user_agent;

    private String user_id;

    public AccessRequest() { }

    public AccessRequest(@NotNull Date timestamp, @NotNull String source_ip, @NotNull String http_method, @NotNull String http_response, String referer, @NotNull String resource, @NotNull Long size, String user_agent, String user_id) {
        this.timestamp = timestamp;
        this.source_ip = source_ip;
        this.http_method = http_method;
        this.http_response = http_response;
        this.referer = referer;
        this.resource = resource;
        this.size = size;
        this.user_agent = user_agent;
        this.user_id = user_id;
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

    public String getHttp_method() {
        return http_method;
    }

    public void setHttp_method(String http_method) {
        this.http_method = http_method;
    }

    public String getHttp_response() {
        return http_response;
    }

    public void setHttp_response(String http_response) {
        this.http_response = http_response;
    }

    public String getReferer() {
        return referer;
    }

    public void setReferer(String referer) {
        this.referer = referer;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public String getUser_agent() {
        return user_agent;
    }

    public void setUser_agent(String user_agent) {
        this.user_agent = user_agent;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
}
