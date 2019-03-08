package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class Members extends AppCompatActivity {

      String check = "" ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.members);
        FirebaseAuth mAuth = FirebaseAuth.getInstance();
        FirebaseUser user = mAuth.getCurrentUser();
        //is user already logged in
        if (user!=null){
            finish();
            Intent i = new Intent(getApplicationContext(), MemberSpace.class);
            startActivity(i);
        }
    }


    public void openLoginPage(View view){
        Intent intent = new Intent(this, MemberArea.class);
        switch(view.getId())
        {
            case R.id.Login:
            check = "Login" ;
                break;
            case R.id.Existmemb:
                check = "ExistMemb" ;
                break;
            case R.id.Newmemb:
                check = "Newmemb" ;
            break;
        }

        intent.putExtra("EXTRA_SESSION_INFO",check);
        // EditText editText = (EditText) findViewById(R.id.editText);
        // String message = editText.getText().toString();
        //intent.putExtra(EXTRA_MESSAGE, message);
        startActivity(intent);

    }
}
