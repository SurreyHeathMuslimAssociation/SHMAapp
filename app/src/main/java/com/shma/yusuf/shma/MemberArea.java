package com.shma.yusuf.shma;

import android.graphics.Color;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MemberArea extends AppCompatActivity {
    private TextView Title;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
//Declarations
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_area);
        String sessionId= getIntent().getStringExtra("EXTRA_SESSION_INFO");
//Assigning elements to variables
        Title = findViewById(R.id.Title);
//Functions and methods
        checks(sessionId);

    }
public void checks(String sessionId){
    View parentLayout = findViewById(android.R.id.content);
    String changed = "" ;
    Snackbar mySnackbar;

    mySnackbar = Snackbar.make(parentLayout, "sessionID is " + sessionId, 6000);
    mySnackbar.show();

    switch(sessionId)
    {
        case "Login":
            changed = "Login" ;
            break;
        case "ExistMemb":
            changed = "Existing Member" ;
            break;
        case "Newmemb" :
            changed = "New Member" ;
            break;
    }
    Title.setText(changed);
}
public void LoginNow(){

}
public void ExistingMember(){

}
public void NewMember(){

}

}
