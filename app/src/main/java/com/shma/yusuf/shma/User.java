package com.shma.yusuf.shma;

public class User {
    private String id;
    private String surname ;
    private String DOB ;

public User (){

}
public User ( String surname , String DOB) {
    //String id,
    //this.id = id ;
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


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}



