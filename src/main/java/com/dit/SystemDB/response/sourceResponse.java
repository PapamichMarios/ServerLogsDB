package com.dit.SystemDB.response;

import java.util.List;

public class SourceResponse {

    private List<Object[]> result;

    public SourceResponse() { }

    public SourceResponse(List<Object[]> result) {
        this.result = result;
    }

    public List<Object[]> getResult() {
        return result;
    }

    public void setResult(List<Object[]> result) {
        this.result = result;
    }
}
