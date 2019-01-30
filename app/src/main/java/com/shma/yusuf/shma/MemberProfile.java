package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class MemberProfile extends AppCompatActivity {
    FirebaseAuth auth;
    FirebaseUser user;
    TextView SHMAProfile;

    private void Logout(){
        auth.signOut();
        Intent i = new Intent(this, MainActivity.class);
        startActivity (i);
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_profile);
        auth = FirebaseAuth.getInstance();
        user = auth.getCurrentUser();
        SHMAProfile = findViewById(R.id.SHMAID);
        SHMAProfile.setText(user.getEmail());
    }


    public void signOut(View v){
        Logout();
    }
}
