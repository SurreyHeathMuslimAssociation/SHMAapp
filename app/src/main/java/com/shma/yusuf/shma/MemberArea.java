package com.shma.yusuf.shma;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.constraint.ConstraintLayout;
import android.support.design.widget.Snackbar;
import android.support.v4.widget.NestedScrollView;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
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
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MemberArea extends AppCompatActivity {
    private Switch familyswitch;
    private TextView Title , Password, Email, Info, Forgotpwd;
    private TextView  SHMAid,FirstName,LastName,DOBfield,Adr1Field, Adr2Field,TownField, PostCodeField,PhoneNum;
    private NestedScrollView scrollview;
    private LinearLayout commentsLayout;
    private Button LoginBtn;
    private int counter = 5;
    private FirebaseAuth mAuth;
    String sessionId;
    String usr_SHMAID,firstname,lastname,DOB,usr_email ,Phoneno, usr_password, addr1,addr2,townfield,postcode,MembershipType, Status;
    DatabaseReference mDatabase;
    List<User> users = new ArrayList<>();
    //checkall fields on entry
    private List<TextView> lstTexts = new ArrayList<TextView>();
   //number of children that can be added
    final Integer N = 2;
    final EditText[] ExtraEditTexts = new EditText[N]; // create an empty array;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
    //Declarations
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_area);
        ScrollView sv = new ScrollView(this);
        sessionId = getIntent().getStringExtra("EXTRA_SESSION_INFO");
        mAuth = FirebaseAuth.getInstance();
        //Assigning elements to variables
        SetUpUIelements();
        CorrectElements();
        AddFieldsToList();
        users.clear();
        mDatabase = FirebaseDatabase.getInstance().getReference();
        //Functions and methods and Assigning click listeners on elements
        Forgotpwd.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), Password.class));

            }
        });
        familyswitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked == true){
                    CreateChildrenBoxes();
                }else{
                    RemoveChildrenBoxes();
                }
            }
        });


    }

    private void RemoveChildrenBoxes(){
        for (int i = 0; i < N; i++) {
           EditText NewEditText = new EditText(this);
            NewEditText = ExtraEditTexts[i] ;
            commentsLayout.removeView(NewEditText);
        }


    }

    private void CreateChildrenBoxes(){
   for (int i = 0; i < N; i++) {
            // create a new textview
            final EditText rowTextView = new EditText(this);

            // set some properties of rowTextView or something
            rowTextView.setHint("Child Number" + i);

            // add the textview to the linearlayout
            commentsLayout.addView(rowTextView);

            // save a reference to the textview for later
            ExtraEditTexts[i] = rowTextView;
        }
    }

    public void Getuserdata(){
        if (sessionId.equals("Login")) {
            usr_email =Email.getText().toString().trim();
            usr_password = Password.getText().toString().trim();
        } else if (sessionId.equals("ExistMemb"))    {
            usr_SHMAID = SHMAid.getText().toString().trim();
            usr_email =Email.getText().toString().trim();
            usr_password = Password.getText().toString().trim();
    }else{
            DOB =DOBfield.getText().toString().trim();
            usr_email =Email.getText().toString().trim();
            usr_password = Password.getText().toString().trim();
            addr1  =Adr1Field.getText().toString().trim();
            addr2 = Adr2Field.getText().toString().trim();
            townfield = TownField.getText().toString().trim();
            postcode =PostCodeField.getText().toString().trim();
            firstname = FirstName.getText().toString().trim();
            lastname =LastName.getText().toString().trim();
            Phoneno = PhoneNum.getText().toString().trim();
            if(familyswitch.isChecked()){
                MembershipType =  "Family";
            }else
                MembershipType =  "Single";  }
                Status = "Applied";


    }
public void SetUpUIelements(){
    commentsLayout= findViewById(R.id.LinearLayoutscr);
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
    scrollview = findViewById(R.id.nestedScrollView);
    FirstName = findViewById(R.id.firstName);
    LastName = findViewById(R.id.lastName);
    PhoneNum = findViewById(R.id.Phonenum);
    }
    private void resizeElements(){
        ConstraintLayout.LayoutParams params = (ConstraintLayout.LayoutParams) scrollview.getLayoutParams();
        ConstraintLayout.LayoutParams newParams =new ConstraintLayout.LayoutParams(ConstraintLayout.LayoutParams.WRAP_CONTENT, ConstraintLayout.LayoutParams.WRAP_CONTENT);
            newParams.bottomToBottom = params.bottomToBottom ;
            newParams.endToEnd = params.endToEnd ;
            newParams.horizontalBias = params.horizontalBias ;
            newParams.startToStart = params.startToStart ;
            newParams.topToTop = params.topToTop ;
            //newParams.verticalBias = params.verticalBias;
            // newParams.topMargin = params.topMargin;
            newParams.setMargins(0, 0, 0, 600);
            scrollview.setLayoutParams(newParams);

        }


    public boolean checkAllTV(List<TextView> allTV){

        for(TextView tv : allTV){
            if(tv.getText().toString().equals("")||tv.getText().toString()==null)
                return false;
        }
        return true;
    }

    public void CorrectElements(){
        if (sessionId.equals("Login")) {
           resizeElements();
            Title.setText("Login");
            familyswitch.setVisibility(View.GONE);
            SHMAid.setVisibility(View.GONE);
            FirstName.setVisibility(View.GONE);
            DOBfield.setVisibility(View.GONE);
            LastName.setVisibility(View.GONE);
            Adr1Field.setVisibility(View.GONE);
            PhoneNum.setVisibility(View.GONE);
            Adr2Field.setVisibility(View.GONE);
            TownField.setVisibility(View.GONE);
            PostCodeField.setVisibility(View.GONE);

        }else if (sessionId.equals("ExistMemb")){
            resizeElements();
            Title.setText("First Time Setup");
            Forgotpwd.setVisibility(View.GONE);
            Info.setVisibility(View.GONE);
            familyswitch.setVisibility(View.GONE);
            LoginBtn.setText("Register");
            FirstName.setVisibility(View.GONE);
            DOBfield.setVisibility(View.GONE);
            LastName.setVisibility(View.GONE);
            Adr1Field.setVisibility(View.GONE);
            PhoneNum.setVisibility(View.GONE);
            Adr2Field.setVisibility(View.GONE);
            TownField.setVisibility(View.GONE);
            PostCodeField.setVisibility(View.GONE);
        }else {
            Title.setText("Thinking of Joining?");
            Title.setTextSize(28);
            LoginBtn.setText("Register");
            SHMAid.setVisibility(View.GONE);
            Forgotpwd.setVisibility(View.GONE);
            Info.setVisibility(View.GONE);

        }

    }

private void AddFieldsToList(){
    List<TextView> namesList;
    if (sessionId.equals("Login")) {
        namesList = Arrays.asList(Password,Email);
    }else if (sessionId.equals("ExistMemb")){
        namesList = Arrays.asList(Password,Email,SHMAid);
    }else {
       namesList = Arrays.asList(Password,Email,FirstName,LastName,DOBfield,Adr1Field, Adr2Field,TownField, PostCodeField,PhoneNum);
    }
    lstTexts.addAll(namesList);
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

    private void checkEmailVerification(){

        FirebaseUser firebaseUser = FirebaseAuth.getInstance().getCurrentUser();
        Boolean emailflag = firebaseUser.isEmailVerified();

        //startActivity(new Intent(MemberArea.this, MemberProfile.class));

      if(emailflag){
          finish();
          //below is the sending of the shmaID once they log in for the first time
          startActivity(new Intent(MemberArea.this, MemberSpace.class));
      }else{
           PopupMessage("Verify your email");
            mAuth.signOut();
                  }
    }

    private void validate() {
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

    private void sendEmailVerification(){
        FirebaseUser firebaseUser = mAuth.getCurrentUser();
        if(firebaseUser!=null){
            firebaseUser.sendEmailVerification().addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if(task.isSuccessful()){
                  if (sessionId.equals("ExistMemb")){
                            sendUserDataExistMem();
                            }else{
                      sendUserDataNewMem();
                  }

                        // mAuth.signOut();
                        finish();
                        Intent intent = new Intent(getApplicationContext(), WelcomeMessage.class);
                        //intent.putExtra("EXTRA_SESSION_INFO","Login");
                        startActivity(intent);
                    }else{
                        Toast.makeText(getApplicationContext(), "Verification mail has'nt been sent!", Toast.LENGTH_SHORT).show();
                    }
                }
            });
        }
    }



public void LoginNow(View v) {
    Getuserdata();
    boolean empty = checkAllTV(lstTexts);
    if (sessionId.equals("Login")) {
        if(empty == true){
            validate();
        }else{
            PopupMessage("Please fill in all available fields");
        }


    } else if (sessionId.equals("ExistMemb")) {
       // usr_SHMAID = SHMAid.getText().toString().trim();
        //usr_email = Email.getText().toString().trim();
       // usr_password = Password.getText().toString().trim();

        if (empty == false) {
            PopupMessage("Please fill in all available fields");
        } else {          //check the shmaID then add the login details into the firebase members database table
            Query query = mDatabase.child("shmaIdsOnApp").orderByKey().equalTo(SHMAid.getText().toString());
            query.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                    if (dataSnapshot.exists()) {

                        for (DataSnapshot m : dataSnapshot.getChildren()) {
                          PopupMessage("You are already a member");
                        }
                    } else {

                        mAuth.createUserWithEmailAndPassword(usr_email, usr_password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
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

                }
                @Override
                public void onCancelled(@NonNull DatabaseError databaseError) {

                }
            });

            }

    }else if ((sessionId.equals("Newmemb"))) {
        //Brand New Member -> Send the details to Soyab for adding to our Offline database
       /* usr_email = Email.getText().toString().trim();
        usr_password = Password.getText().toString().trim();
        DOB = DOBfield.getText().toString().trim();
        addr1 = Adr1Field.getText().toString().trim();
        addr2 = Adr2Field.getText().toString().trim();
        townfield = TownField.getText().toString().trim();
        postcode =  PostCodeField.getText().toString().trim();*/

        if (empty == false) {
            PopupMessage("Please fill in all available fields");
        } else {
            mAuth.createUserWithEmailAndPassword(usr_email, usr_password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                @Override
                public void onComplete(@NonNull Task<AuthResult> task) {

                    if (task.isSuccessful()) {
                      //  sendUserDataNewMem();
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

        }



}

    private void sendUserDataExistMem() {
        Query query = mDatabase.child("offline_members").child(SHMAid.getText().toString());
        query.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
                DatabaseReference myRef = firebaseDatabase.getReference("members").child(mAuth.getUid());
                if (dataSnapshot.exists()) {

                        firstname = dataSnapshot.child("firstName").getValue(String.class);
                        lastname = dataSnapshot.child("lastName").getValue(String.class);
                        DOB = dataSnapshot.child("DOB").getValue(String.class);
                        MembershipType = dataSnapshot.child("membershipType").getValue(String.class);
                        User usr_profile = new User(usr_SHMAID, firstname, lastname, DOB, usr_email,MembershipType);
                        myRef.setValue(usr_profile);
                }else{
                    Toast.makeText(getApplicationContext(), "Empty snapshot", Toast.LENGTH_SHORT).show();
                }

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });
    }
    private void sendUserDataNewMem() {
        FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference myRef = firebaseDatabase.getReference("members").child(mAuth.getUid());

       User NEWusr_profile = new User(usr_SHMAID, firstname, lastname, DOB, usr_email, addr1,addr2,townfield,postcode,Phoneno, MembershipType,Status);
        myRef.setValue(NEWusr_profile);
    }
}

