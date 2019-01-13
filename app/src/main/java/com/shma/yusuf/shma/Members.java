package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class Members extends AppCompatActivity {

    private  String check = "" ;
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
            default:
                throw new RuntimeException("Unknow button ID");
        }

        intent.putExtra("EXTRA_SESSION_INFO",check);
        // EditText editText = (EditText) findViewById(R.id.editText);
        // String message = editText.getText().toString();
        //intent.putExtra(EXTRA_MESSAGE, message);
        startActivity(intent);

    }
}
