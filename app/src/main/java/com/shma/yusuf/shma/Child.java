package com.shma.yusuf.shma;

public class Child {
    private String fullName;
    private String dob;

    public Child(){

    }

    public Child(String fullName,String DOB){
        this.fullName = fullName;
        this.dob = DOB;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDOB() {
        return dob;
    }

    public void setDOB(String DOB) {
        this.dob = DOB;
    }
}
