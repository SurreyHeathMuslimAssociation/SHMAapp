package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class MemberProfile extends AppCompatActivity {
   private TextView SHMAID,firstname , surname , DOB;
   private Button logout;
   private FirebaseAuth auth = FirebaseAuth.getInstance();
   private FirebaseUser user;
   private FirebaseDatabase firebaseDatabase;

    private void SetUpUIelements(){
        logout = findViewById(R.id.Logout);
        SHMAID = findViewById(R.id.usr_shmaid);
        firstname =  findViewById(R.id.usr_firstname);
        surname =  findViewById(R.id.usr_surname);
        DOB =  findViewById(R.id.usr_DOB);
    }
    public void Logout(){
        auth.signOut();
        finish();
         }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_profile);
        firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference databaseReference = firebaseDatabase.getReference("members").child(auth.getUid());
        SetUpUIelements();
        //Database listeners
        databaseReference .addValueEventListener(new ValueEventListener(){

            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                User userProfile = dataSnapshot.getValue(User.class);

                SHMAID.setText("Welcome Member: " + userProfile.getShmaId());
                firstname.setText("Name: " + userProfile.getFirstName());
                surname.setText("Age: " + userProfile.getLastName());
                DOB.setText("Email: " + userProfile.getDOB());

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {
                Toast.makeText(getApplicationContext(), "Signed out", Toast.LENGTH_SHORT).show();
            }

        });

    }

    public void LogoutNow(View v){
        Logout();
    }

}
