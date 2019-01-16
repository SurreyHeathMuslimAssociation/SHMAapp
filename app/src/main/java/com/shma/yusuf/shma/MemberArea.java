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

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class MemberArea extends AppCompatActivity {
    private Switch familyswitch;
    private Button LoginBtn;
    private TextView DOBTitle;
    private TextView DOBfield;
    private TextView Adr1Title;
    private TextView Adr1Field;
    private TextView Adr2Title;
    private TextView Adr2Field;
    private TextView TownTitle;
    private TextView TownField;
    private TextView PostCodeTitle;
    private TextView PostCodeField;
    private TextView Title;
    private TextView SHMAid;
    private TextView Password;
    private TextView Email;
    private String currentUserID;
    private FirebaseAuth mAuth;
    String sessionId;
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
        familyswitch = findViewById(R.id.FamilySwitch);
        Title = findViewById(R.id.Title);
        SHMAid = findViewById(R.id.SHMAfield);
        Password = findViewById(R.id.PasswordField);
        Email = findViewById(R.id.EmailField);
        DOBTitle = findViewById(R.id.DOBtitle);
        DOBfield = findViewById(R.id.DobField);
        Adr1Title = findViewById(R.id.Address1title);
        Adr1Field = findViewById(R.id.Address1Field);
        Adr2Title = findViewById(R.id.Address2title);
        Adr2Field = findViewById(R.id.Address2Field);
        TownTitle = findViewById(R.id.TownTitle);
        TownField = findViewById(R.id.TownField);
        PostCodeTitle =findViewById(R.id.PostCodeTitle);
        PostCodeField = findViewById(R.id.PostCodeField) ;
        LoginBtn = findViewById(R.id.LoginButton);
        users.clear();
        mDatabase = FirebaseDatabase.getInstance().getReference();
    //Functions and methods
       CorrectElements();
       // readfromFirebase("offline_members");
       // readfromFirebasedb2("shmaIdsOnApp");





    }

    public void CorrectElements(){
        if (sessionId.equals("Login")) {
            familyswitch.setVisibility(View.INVISIBLE);
            SHMAid.setVisibility(View.INVISIBLE);
            DOBTitle.setVisibility(View.INVISIBLE);
            DOBfield.setVisibility(View.INVISIBLE);
            Adr1Title.setVisibility(View.INVISIBLE);
            Adr1Field.setVisibility(View.INVISIBLE);
            Adr2Title.setVisibility(View.INVISIBLE);
            Adr2Field.setVisibility(View.INVISIBLE);
            TownTitle.setVisibility(View.INVISIBLE);
            TownField.setVisibility(View.INVISIBLE);
            PostCodeTitle.setVisibility(View.INVISIBLE);
            PostCodeField.setVisibility(View.INVISIBLE);
        }else if (sessionId.equals("ExistMemb")){
            familyswitch.setVisibility(View.INVISIBLE);
            LoginBtn.setText("Register");
            DOBTitle.setVisibility(View.INVISIBLE);
            DOBfield.setVisibility(View.INVISIBLE);
            Adr1Title.setVisibility(View.INVISIBLE);
            Adr1Field.setVisibility(View.INVISIBLE);
            Adr2Title.setVisibility(View.INVISIBLE);
            Adr2Field.setVisibility(View.INVISIBLE);
            TownTitle.setVisibility(View.INVISIBLE);
            TownField.setVisibility(View.INVISIBLE);
            PostCodeTitle.setVisibility(View.INVISIBLE);
            PostCodeField.setVisibility(View.INVISIBLE);
        }else {
            LoginBtn.setText("Register");


        }

    }

    public void TestArrayListResults(){
        Log.d("size of user array", String.valueOf(users.size()));
        for (User s : users) {

            Log.d( "shmaid ", s.getShmaId());
            if (s.getMembershipType() != null){
                Log.d("membership type", s.getMembershipType());
            }
            if (s.getDOB() != null) {
                Log.d("DOB", s.getDOB());
            }
            Log.d("surname", s.getSurname());
            if (s.getFirstname() != null) {
                Log.d("first name", s.getFirstname());
            }
            Log.d("APP user:", String.valueOf(s.isAPPuser()));
        }
    }

    public void readfromFirebasedb2(String tabletwo){

        mDatabase.child(tabletwo).getRef().addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {

                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {

                    for (User s : users){
                        if (postSnapshot.getKey().equals(s.getShmaId())) {
                            s.setAPPuser(true);
                        }
                    }
                }
                TestArrayListResults();

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
    /*public void connectionFirebase(){

       mAuth = FirebaseAuth.getInstance();
        currentUserID = mAuth.getCurrentUser().getUid();

        mDatabase.child(currentUserID).addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {

                         String email = postSnapshot.child("email").getValue(String.class);

               Log.d("individual", email  );

                }

            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.d("DB connect error","verification"  );
            }
        });
    }*/

public void checks(String sessionId){
    View parentLayout = findViewById(android.R.id.content);
    String changed = "" ;
    Snackbar mySnackbar;

    mySnackbar = Snackbar.make(parentLayout, "sessionID is " + sessionId, 6000);
    mySnackbar.show();

    switch(sessionId)
    {
        case "Login":
            changed = "Login" ;
            break;
        case "ExistMemb":
            changed = "Existing Member" ;
            break;
        case "Newmemb" :
            changed = "New Member" ;
            break;
    }
    Title.setText(changed);
}
public void LoginNow(View v) {

    boolean isregistered = true ;
    if (sessionId.equals("Login")) {
        if (Email.getText().toString().equals("") && Password.getText().toString().equals("")) {
            PopupMessage("Please fill in all available fields");
        } else {
            mAuth.signInWithEmailAndPassword(Email.getText().toString(), Password.getText().toString())
                    .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (task.isSuccessful()) {
                                finish();
                                Intent i = new Intent(getApplicationContext(), MemberProfile.class);
                                startActivity(i);
                            } else {
                                PopupMessage("User not found");
                            }
                        }
                    });
        }

    } else if (sessionId.equals("ExistMemb")) {

        if (Email.getText().toString().equals("") || Password.getText().toString().equals("") || SHMAid.getText().toString().equals("")) {
            PopupMessage("Please fill in all available fields");
        } else {          //check the shmaID then add the login details into the firebase members database table
            Query query = mDatabase.child("shmaIdsOnApp").orderByKey().equalTo(SHMAid.getText().toString());
            query.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                    if (dataSnapshot.exists()) {

                        for (DataSnapshot m : dataSnapshot.getChildren()) {
                            Log.d("Are you already an app user:", String.valueOf((m.getValue())));
                    PopupMessage("You are already a member");
                        }
                    }else {


                        mAuth.createUserWithEmailAndPassword(Email.getText().toString(),Password.getText().toString()).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                            @Override
                            public void onComplete(@NonNull Task<AuthResult> task) {

                                if (task.isSuccessful()){
                                    FirebaseUser user = mAuth.getCurrentUser(); //You Firebase user
                                    // user registered, start profile activity

                                    PopupMessage("Account Created");
                                    finish();

                                    //startActivity(new Intent(getApplicationContext(), UserMainPage.class));
                                }
                                else{
                                    PopupMessage("Could not create account. Please try again");
                                }
                            }
                        });
                        PopupMessage("Existing Member Created");

                    }

                }

                @Override
                public void onCancelled(@NonNull DatabaseError databaseError) {

                }
            }) ;

           }
    } else if ((sessionId.equals("NewMember"))) {
        //Brand New Member -> Send the details to Soyab for adding to our Offline database

    }



}

public void UpdateView(FirebaseUser user){

}

public boolean checkMemberTbl(boolean isregistered){

        for (User secondchk : users){
            Log.d("shma id " , secondchk.getShmaId() + "shmaidbox" + SHMAid.getText().toString());
            if (SHMAid.getText().toString() .equals(secondchk.getShmaId())) {
                PopupMessage("Member Already Exists!");
                isregistered = true;
                break;
            }else {
                isregistered = false ;

            }
        }
        return isregistered;
    }
    public void checkMemberSearchTbl( ){
                    for (User s : users) {
                // Log.d(TAG, "date user " + date + "date arraylist" + s.getDOB());
                if (SHMAid.getText().toString().equals(s.getShmaId())) {
                      //ADD DETAILS TO FIREBASE
                    PopupMessage("member will b added to firebase");


                    break;
                }else{

                }
                }
    }

}

