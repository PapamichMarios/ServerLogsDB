package com.dit.SystemDB.response;

import java.util.List;

public class Function1Response<T> {

    private List<T> logs;

    public Function1Response() {
    }

    public Function1Response(List<T> logs) {
        this.logs = logs;
    }

    public List<T> getLogs() {
        return logs;
    }

    public void setLogs(List<T> logs) {
        this.logs = logs;
    }
}
