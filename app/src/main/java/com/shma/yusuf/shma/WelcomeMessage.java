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
    private TextView Name ;
    private FirebaseAuth mAuth = FirebaseAuth.getInstance();
    private FirebaseDatabase mDatabase = FirebaseDatabase.getInstance();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome_message);
        DatabaseReference databaseReference = mDatabase.getReference("members").child(mAuth.getUid());
        SetUpUIelements();
        databaseReference .addValueEventListener(new ValueEventListener(){

            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                User userProfile = dataSnapshot.getValue(User.class);
                String sourceString = "Welcome, " + "<b>" +userProfile.getFirstName() + " " + userProfile.getLastName() +"</b> "  ;
                Name.setText(Html.fromHtml(sourceString));
                //Name.setText("Welcome," + userProfile.getFirstName() + " " + userProfile.getLastName());

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {
                Toast.makeText(getApplicationContext(), "Signed out", Toast.LENGTH_SHORT).show();
            }

        });

           }
    public void SetUpUIelements(){
        Name = findViewById(R.id.Nametxt);

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
