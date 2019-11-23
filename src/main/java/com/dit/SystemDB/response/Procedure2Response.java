package com.dit.SystemDB.response;

import java.util.List;

public class Procedure2Response {

    private List<Object[]> result;

    public Procedure2Response() { }

    public Procedure2Response(List<Object[]> result) {
        this.result = result;
    }

    public List<Object[]> getResult() {
        return result;
    }

    public void setResult(List<Object[]> result) {
        this.result = result;
    }
}