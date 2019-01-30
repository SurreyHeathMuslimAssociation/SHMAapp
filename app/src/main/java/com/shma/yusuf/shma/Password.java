package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;

public class Password extends AppCompatActivity {
    private EditText passwordEmail;
    private Button resetPassword;
    private FirebaseAuth firebaseAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_password);
        passwordEmail = findViewById(R.id.PwdReset);
        resetPassword = findViewById(R.id.Resetpwd);
        firebaseAuth = FirebaseAuth.getInstance();

        resetPassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String useremail = passwordEmail.getText().toString().trim();

                if(useremail.equals("")){
                    Toast.makeText(getApplicationContext(), "Please enter your registered email", Toast.LENGTH_SHORT).show();
                }else{
                    firebaseAuth.sendPasswordResetEmail(useremail).addOnCompleteListener(new OnCompleteListener<Void>() {
                        @Override
                        public void onComplete(@NonNull Task<Void> task) {
                            if(task.isSuccessful()){
                                Toast.makeText(getApplicationContext(), "Password reset email has been sent!", Toast.LENGTH_SHORT).show();
                                finish();
                                startActivity(new Intent(getApplicationContext(), MainActivity.class));
                            }else{
                                Toast.makeText(getApplicationContext(), "Error in sending password reset email", Toast.LENGTH_SHORT).show();
                            }
                        }
                    });

                }


                }
            });

    }

}
