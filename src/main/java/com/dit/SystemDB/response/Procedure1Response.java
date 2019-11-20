package com.dit.SystemDB.response;

import java.util.List;

public class Procedure1Response {

    private List<Object[]> result;

    public Procedure1Response() { }

    public Procedure1Response(List<Object[]> result) {
        this.result = result;
    }

    public List<Object[]> getResult() {
        return result;
    }

    public void setResult(List<Object[]> result) {
        this.result = result;
    }
}
