package com.shma.yusuf.shma;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;


public class MainActivity extends AppCompatActivity {
     public static final String EXTRA_MESSAGE = "com.shma.yusuf.shma.MESSAGE";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FirebaseAuth mAuth = FirebaseAuth.getInstance();
        FirebaseUser user = mAuth.getCurrentUser();
        //is user already logged in
        if (user!=null){
            Intent i = new Intent(getApplicationContext(), MemberSpace.class);
            startActivity(i);
        }

          }
    public void openCorp(View view){
        Intent intent = new Intent(this, member_business.class);
        intent.putExtra("FromTheMain", "Main");
        startActivity(intent);

    }

    public void openMember(View view){
        Intent intent = new Intent(this, Members.class);
        // EditText editText = (EditText) findViewById(R.id.editText);
        // String message = editText.getText().toString();
        //intent.putExtra(EXTRA_MESSAGE, message);
        startActivity(intent);

    }






}
