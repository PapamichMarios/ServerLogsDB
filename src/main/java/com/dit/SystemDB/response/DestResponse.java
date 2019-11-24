package com.dit.SystemDB.response;

import java.util.List;

public class DestResponse {

        private List<Object[]> result;

        public DestResponse() { }

        public DestResponse(List<Object[]> result) {
            this.result = result;
        }

        public List<Object[]> getResult() {
            return result;
        }

        public void setResult(List<Object[]> result) {
            this.result = result;
        }
    }
