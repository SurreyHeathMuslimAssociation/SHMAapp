package com.shma.yusuf.shma;

public class Spouse {
    private String FullName;
    private String DOB;
    private String Email;


    public Spouse(){

    }
    public Spouse(String FullName,String DOB,String Email){
        this.FullName = FullName;
        this.DOB = DOB;
        this.Email = Email;
    }
    public String getName() {
        return this.FullName;
    }

    public void setName(String name) {
        this.FullName = name;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }


}
