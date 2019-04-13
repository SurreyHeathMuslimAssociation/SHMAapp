package com.shma.yusuf.shma;

public class Spouse {
    private String SpouseDOB;
    private String SpouseEmail;
    private String SpouseName;

    public Spouse(){

    }
    public Spouse(String SpouseName,String SpouseDOB,String SpouseEmail){
        this.SpouseName = SpouseName;
        this.SpouseDOB = SpouseDOB;
        this.SpouseEmail = SpouseEmail;
    }
    public String getSpouseName() {
        return SpouseName;
    }

    public void setSpouseName(String spouseName) {
        SpouseName = spouseName;
    }

    public String getSpouseDOB() {
        return SpouseDOB;
    }

    public void setSpouseDOB(String spouseDOB) {
        SpouseDOB = spouseDOB;
    }

    public String getSpouseEmail() {
        return SpouseEmail;
    }

    public void setSpouseEmail(String spouseEmail) {
        SpouseEmail = spouseEmail;
    }


}
