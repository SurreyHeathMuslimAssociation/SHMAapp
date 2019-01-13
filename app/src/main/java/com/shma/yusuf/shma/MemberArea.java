package com.shma.yusuf.shma;

import android.graphics.Color;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MemberArea extends AppCompatActivity {
    String sessionId= getIntent().getStringExtra("EXTRA_SESSION_INFO");

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        View parentLayout = findViewById(android.R.id.content);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_area);
        Snackbar mySnackbar;
        mySnackbar = Snackbar.make(parentLayout, "Valid Member with ID of " + sessionId, 6000);
        mySnackbar.getView().setBackgroundColor(Color.GREEN);
        mySnackbar.show();
        
    }
}
