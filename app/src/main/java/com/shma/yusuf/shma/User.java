package com.shma.yusuf.shma;

public class User {
    private String shmaId;
    private String firstName, lastName;
    private String DOB ;
    private String county, town, addressLineOne , addressLineTwo, postcode ;
    private String email, mobileNo ;
    private String membershipType;
    private String status;

    public User(){

    }

    public User(String shmaId, String firstName, String lastName, String DOB, String email) {
        this.shmaId = shmaId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.DOB = DOB;
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
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



}



