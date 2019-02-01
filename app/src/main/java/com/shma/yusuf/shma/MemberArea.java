package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class MemberArea extends AppCompatActivity {
    private Switch familyswitch;
    private TextView Title , Password, Email, Info, Forgotpwd;
    private TextView  DOBfield;
    private TextView Adr1Field;
    private TextView  Adr2Field;
    private TextView  TownField;
    private TextView PostCodeField;
    private TextView SHMAid;
    private Button LoginBtn;
    private int counter = 5;
    private FirebaseAuth mAuth;
    String sessionId;
    String usr_SHMAID,usr_email , usr_password;
    DatabaseReference mDatabase;
    List<User> users = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
    //Declarations
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_area);
        sessionId = getIntent().getStringExtra("EXTRA_SESSION_INFO");
        mAuth = FirebaseAuth.getInstance();
        //Assigning elements to variables
        SetUpUIelements();
        CorrectElements();
        users.clear();
        mDatabase = FirebaseDatabase.getInstance().getReference();
        //Functions and methods and Assigning click listeners on elements
        Forgotpwd.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), Password.class));

            }
        });

    }
public void SetUpUIelements(){
    familyswitch = findViewById(R.id.FamilySwitch);
    Title = findViewById(R.id.Title);
    SHMAid = findViewById(R.id.SHMAfield);
    Password = findViewById(R.id.PasswordField);
    Email = findViewById(R.id.EmailField);

    DOBfield = findViewById(R.id.DobField);

    Adr1Field = findViewById(R.id.Address1Field);

    Adr2Field = findViewById(R.id.Address2Field);
    Info = findViewById(R.id.LoginAttempts);

    TownField = findViewById(R.id.TownField);

    PostCodeField = findViewById(R.id.PostCodeField) ;
    LoginBtn = findViewById(R.id.LoginButton);
    Forgotpwd = findViewById(R.id.Forgotpwd);
    }
    public void CorrectElements(){
        if (sessionId.equals("Login")) {
            Title.setText("Login");
            familyswitch.setVisibility(View.INVISIBLE);
            SHMAid.setVisibility(View.INVISIBLE);

            DOBfield.setVisibility(View.INVISIBLE);

            Adr1Field.setVisibility(View.INVISIBLE);

            Adr2Field.setVisibility(View.INVISIBLE);

            TownField.setVisibility(View.INVISIBLE);

            PostCodeField.setVisibility(View.INVISIBLE);
        }else if (sessionId.equals("ExistMemb")){
            Title.setText("First Time Setup");
            Forgotpwd.setVisibility(View.INVISIBLE);
            Info.setVisibility(View.INVISIBLE);
            familyswitch.setVisibility(View.INVISIBLE);
            LoginBtn.setText("Register");

            DOBfield.setVisibility(View.INVISIBLE);

            Adr1Field.setVisibility(View.INVISIBLE);

            Adr2Field.setVisibility(View.INVISIBLE);

            TownField.setVisibility(View.INVISIBLE);

            PostCodeField.setVisibility(View.INVISIBLE);
        }else {
            Title.setText("Thinking of Joining?");
            LoginBtn.setText("Register");
            Forgotpwd.setVisibility(View.INVISIBLE);
            Info.setVisibility(View.INVISIBLE);

        }

    }

    public void readfromFirebasedb2(String tabletwo){

        mDatabase.child(tabletwo).getRef().addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {

                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {

                    for (User s : users){
                        if (postSnapshot.getKey().equals(s.getShmaId())) {

                        }
                    }
                }


            }
            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });

    }

    public void readfromFirebase(String tableOne){

        mDatabase.child(tableOne).getRef().addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {
                    User usersdb = postSnapshot.getValue(User.class);
                    usersdb.setShmaId(postSnapshot.getKey());
                    users.add(usersdb);
                }

            }
            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.d( "Connection Error with member_offline ",databaseError.toString());

            }

        });

    }


    public void PopupMessage(String Message){
        View parentLayout = findViewById(android.R.id.content);
        String changed = "" ;
        Snackbar mySnackbar;
        mySnackbar = Snackbar.make(parentLayout, Message, 6000);
        TextView mainTextView = (mySnackbar.getView()).findViewById(android.support.design.R.id.snackbar_text);
        mainTextView.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        mySnackbar.show();

    }

    private void checkEmailVerification(){

        FirebaseUser firebaseUser = FirebaseAuth.getInstance().getCurrentUser();
        Boolean emailflag = firebaseUser.isEmailVerified();

        //startActivity(new Intent(MemberArea.this, MemberProfile.class));

      if(emailflag){
          finish();
          //below is the sending of the shmaID once they log in for the first time
          startActivity(new Intent(MemberArea.this, MemberProfile.class));
      }else{
           PopupMessage("Verify your email");
            mAuth.signOut();
                  }
    }

    private void validate() {
        usr_email = Email.getText().toString().trim();
        usr_password = Password.getText().toString().trim();
        if (Email.getText().toString().equals("") && Password.getText().toString().equals("")) {
            PopupMessage("Please fill in all available fields");
        } else {
            mAuth.signInWithEmailAndPassword(usr_email, usr_password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                @Override
                public void onComplete(@NonNull Task<AuthResult> task) {
                    if (task.isSuccessful()) {
                        checkEmailVerification();
                    } else {
                        PopupMessage("Login Failed");
                        counter--;
                        Info.setText("No of attempts remaining: " + counter);
                        if (counter == 0) {
                            Info.setText("Number of attempts exceeded");
                            LoginBtn.setEnabled(false);
                        }
                    }
                }
            });

        }
    }

    private void sendEmailVerification(){
        FirebaseUser firebaseUser = mAuth.getCurrentUser();
        if(firebaseUser!=null){
            firebaseUser.sendEmailVerification().addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if(task.isSuccessful()){
                      //  sendUserData();
                        sendUserData();
                        Toast.makeText(getApplicationContext(), "Successfully Registered, Verification mail sent!", Toast.LENGTH_SHORT).show();
                        mAuth.signOut();
                        finish();
                        Intent intent = new Intent(getApplicationContext(), MemberArea.class);
                        intent.putExtra("EXTRA_SESSION_INFO","Login");
                        startActivity(intent);
                    }else{
                        Toast.makeText(getApplicationContext(), "Verification mail has'nt been sent!", Toast.LENGTH_SHORT).show();
                    }
                }
            });
        }
    }

public void LoginNow(View v) {
    if (sessionId.equals("Login")) {
         validate();

    } else if (sessionId.equals("ExistMemb")) {

        if (Email.getText().toString().equals("") || Password.getText().toString().equals("") || SHMAid.getText().toString().equals("")) {
            PopupMessage("Please fill in all available fields");
        } else {          //check the shmaID then add the login details into the firebase members database table
            /*Query query = mDatabase.child("shmaIdsOnApp").orderByKey().equalTo(SHMAid.getText().toString());
            query.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                    if (dataSnapshot.exists()) {

                        for (DataSnapshot m : dataSnapshot.getChildren()) {
                            Log.d("Are you already an app user:", String.valueOf((m.getValue())));
                    PopupMessage("You are already a member");
                        }
                    }else {*/
            usr_SHMAID = SHMAid.getText().toString().trim();
            usr_email = Email.getText().toString().trim();
            usr_password = Password.getText().toString().trim();
            mAuth.createUserWithEmailAndPassword(usr_email,usr_password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                @Override
                public void onComplete(@NonNull Task<AuthResult> task) {

                    if (task.isSuccessful()) {
                        sendEmailVerification();
                        /*PopupMessage("Account Created Successfully");
                        FirebaseUser user = mAuth.getCurrentUser(); //You Firebase user
                        // user registered, start profile activity
                        finish();
                        Intent intent = new Intent(getApplicationContext(), MemberArea.class);
                        intent.putExtra("EXTRA_SESSION_INFO","Login");
                        startActivity(intent);*/
                    } else {
                        PopupMessage("Could not create account. Please try again");
                    }
                }
            });


        }

                /*@Override
                public void onCancelled(@NonNull DatabaseError databaseError) {

                }
            }) ;*/

    } else if ((sessionId.equals("NewMember"))) {
        //Brand New Member -> Send the details to Soyab for adding to our Offline database

    }



}

    private void sendUserData() {
        FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference myRef;
        User usr_profile = new User(usr_SHMAID,"Yusuf","Dinah","over 90",usr_email) ;
        myRef = firebaseDatabase.getReference("members").child(mAuth.getUid());
        myRef.setValue(usr_profile);

    }
}

