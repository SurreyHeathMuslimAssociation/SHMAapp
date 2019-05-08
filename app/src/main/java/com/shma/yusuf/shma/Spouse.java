package com.shma.yusuf.shma;

public class Spouse {
    private String fullName;
    private String dob;
    private String email;


    public Spouse(){

    }
    public Spouse(String fullName,String dob,String email){
        this.fullName = fullName;
        this.dob = dob;
        this.email = email;
    }
    public String getfullName() {
        return fullName;
    }

    public void setfullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDOB() {
        return dob;
    }

    public void setDOB(String DOB) {
        this.dob = DOB;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


}
