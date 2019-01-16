package com.shma.yusuf.shma;

public class User {
    private String shmaId;
    private String firstname ;
    private String surname ;
    private String DOB ;
    private String membershipType;
    private boolean APPuser;
public User (){

}

public User(String membershipType, String firstname, String surname , String DOB){
   this.membershipType = membershipType;
    this.firstname = firstname ;
        this.surname = surname;
    this.DOB = DOB;
}

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getMembershipType() {
        return membershipType;
    }

    public void setMembershipType(String membershipType) {
        this.membershipType = membershipType;
    }

    public String getShmaId() {
        return shmaId;
    }

    public void setShmaId(String shmaId) {
        this.shmaId = shmaId;
    }

    public boolean isAPPuser() {
        return APPuser;
    }

    public void setAPPuser(boolean APPuser) {
        this.APPuser = APPuser;
    }
}



