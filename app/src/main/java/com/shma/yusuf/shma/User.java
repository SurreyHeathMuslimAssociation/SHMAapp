package com.shma.yusuf.shma;

public class User {
    private String shmaId;
    private String firstName;
    private String lastName;
    private String DOB;
    private String town, addressLineOne , addressLineTwo, postcode;
    private String email;
    private String mobileNo;
    private String membershipType;
    private String status;

   public User(){

    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }
    public User(String shmaId,String firstName, String lastName,String DOB, String email, String membershipType ){
        this.shmaId = shmaId;
        this.membershipType = membershipType;
        this.DOB = DOB;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    public String getMobileNo() {
        return mobileNo;
    }
    public User(String shmaId, String firstName, String lastName, String DOB, String email, String addressLineOne, String addressLineTwo, String town, String postcode, String mobileNo, String membershipType, String status ) {
        this.shmaId = shmaId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.DOB = DOB;
        this.email = email;
        this.addressLineOne = addressLineOne;
        this.addressLineTwo = addressLineTwo;
        this.town = town;
        this.postcode = postcode;
        this.mobileNo = mobileNo;
        this.membershipType = membershipType;
        this.status = status;
    }

    public String getEmail() {
        return email;
    }
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    public String getAddressLineOne() {
        return addressLineOne;
    }

    public void setAddressLineOne(String addressLineOne) {
        this.addressLineOne = addressLineOne;
    }

    public String getAddressLineTwo() {
        return addressLineTwo;
    }

    public void setAddressLineTwo(String addressLineTwo) {
        this.addressLineTwo = addressLineTwo;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

}



