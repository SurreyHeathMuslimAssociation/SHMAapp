package com.shma.yusuf.shma;

public class Child {
    private String FullName;
    private String DOB;

    public Child(){

    }

    public Child(String FullName,String DOB){
        this.FullName = FullName;
        this.DOB = DOB;

    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String fullName) {
        FullName = fullName;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }
}
