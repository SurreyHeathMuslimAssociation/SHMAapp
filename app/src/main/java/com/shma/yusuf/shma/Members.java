package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class Members extends AppCompatActivity {

      String check = "" ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.members);

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
