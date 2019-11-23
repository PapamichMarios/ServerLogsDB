package com.dit.SystemDB.response;

import java.util.List;

public class Procedure3Response {

    private List<Object[]> result;

    public Procedure3Response() { }

    public Procedure3Response(List<Object[]> result) {
        this.result = result;
    }

    public List<Object[]> getResult() {
        return result;
    }

    public void setResult(List<Object[]> result) {
        this.result = result;
    }
}