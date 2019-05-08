package com.shma.yusuf.shma;

import android.content.Intent;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class WelcomeMessage extends AppCompatActivity {
    private TextView Name ,scndGreeting;
    private FirebaseAuth mAuth = FirebaseAuth.getInstance();
    private FirebaseDatabase mDatabase = FirebaseDatabase.getInstance();
    private String type;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome_message);
        Intent intent = getIntent();
        type = intent.getStringExtra("TYPE");
        DatabaseReference databaseReference = mDatabase.getReference("members").child(mAuth.getUid());
        SetUpUIelements();
        databaseReference .addValueEventListener(new ValueEventListener(){

            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                User userProfile = dataSnapshot.getValue(User.class);
                String sourceString = "Welcome, " + "<b>" +userProfile.getFirstName() + " " + userProfile.getLastName() +"</b> "  ;
                Name.setText(Html.fromHtml(sourceString));
                //Name.setText("Welcome," + userProfile.getFirstName() + " " + userProfile.getLastName());
                if (type.equals("NewMem")){
                    String message = "Just few more steps to go:\n\n Verfiy your account via the link in your email\nSetup your monthly standing order to the following account:\n\nSurrey Heath Muslim Association\nSort Code: 30-00-83\nAccount Number: 01222601\n\nThe payment reference must be: SHMA-" +userProfile.getShmaId();
                    scndGreeting.setText(message);
                }

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {
                Toast.makeText(getApplicationContext(), "Signed out", Toast.LENGTH_SHORT).show();
            }

        });

           }
    public void SetUpUIelements(){
        Name = findViewById(R.id.Nametxt);
        scndGreeting = findViewById(R.id.scndgreetingMsg);
    }

    public void PopupMessage(String Message){
        View parentLayout = findViewById(android.R.id.content);
        String changed = "" ;
        Snackbar mySnackbar;
        mySnackbar = Snackbar.make(parentLayout, Message, 6000);
        mySnackbar.getView().setBackgroundColor(Color.RED);
        TextView mainTextView = (mySnackbar.getView()).findViewById(android.support.design.R.id.snackbar_text);
        mainTextView.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        mainTextView.setTextColor(Color.BLACK);
        mainTextView.setTextSize(24);
        mySnackbar.show();

    }
    public void backToLogin (View v) {
        Intent intent = new Intent(getApplicationContext(), MemberArea.class);
        intent.putExtra("EXTRA_SESSION_INFO","Login");
        mAuth.signOut();
        finish();
        startActivity(intent);
    }
}
