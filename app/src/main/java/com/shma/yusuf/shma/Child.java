package com.shma.yusuf.shma;

public class Child {
    private String Name;
    private String DOB;

    public Child(){

    }

    public Child(String Name,String DOB){
        this.Name = Name;
        this.DOB = DOB;

    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }
}
