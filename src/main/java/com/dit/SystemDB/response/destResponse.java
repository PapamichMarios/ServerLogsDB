package com.dit.SystemDB.response;

import java.util.List;

public class destResponse {

        private List<Object[]> result;

        public destResponse() { }

        public destResponse(List<Object[]> result) {
            this.result = result;
        }

        public List<Object[]> getResult() {
            return result;
        }

        public void setResult(List<Object[]> result) {
            this.result = result;
        }
    }
