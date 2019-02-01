package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
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

public class MemberProfile extends AppCompatActivity {
   private TextView SHMAID,firstname , surname , DOB;
    private FirebaseAuth auth;
   private FirebaseUser user;
   private TextView SHMAProfile;
    private FirebaseDatabase firebaseDatabase;

    private void SetUpUIelements(){
        SHMAID = findViewById(R.id.usr_shmaid);
        firstname =  findViewById(R.id.usr_firstname);
        surname =  findViewById(R.id.usr_surname);
        DOB =  findViewById(R.id.usr_DOB);
    }
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
                Toast.makeText(getApplicationContext(), databaseError.getCode(), Toast.LENGTH_SHORT).show();
            }
        });
    }


    public void signOut(View v){
        Logout();
    }
}
