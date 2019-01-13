package com.shma.yusuf.shma;

import android.graphics.Color;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MemberArea extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        String sessionId= getIntent().getStringExtra("EXTRA_SESSION_INFO");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_area);
        View parentLayout = findViewById(android.R.id.content);
        Snackbar mySnackbar;
        mySnackbar = Snackbar.make(parentLayout, "sessionID is " + sessionId, 6000);
        mySnackbar.show();

    }
}
