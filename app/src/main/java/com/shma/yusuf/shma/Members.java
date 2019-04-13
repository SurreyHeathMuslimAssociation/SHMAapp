package com.shma.yusuf.shma;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

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

        startActivity(intent);
finish();
    }
}
