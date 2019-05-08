package com.shma.yusuf.shma;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.support.constraint.ConstraintLayout;
import android.support.design.widget.Snackbar;
import android.support.v4.widget.NestedScrollView;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.text.InputType;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.SignInMethodQueryResult;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

public class MemberArea extends AppCompatActivity {
    private View parentLayout;
    private ProgressBar Progressbar;
    private Switch familyswitch;
    private TextView Title, Forgotpwd,lblAddchild, lblRemovechild,Notice;
    private WebView urlWebView;
    private EditText  SHMAid,FirstName,LastName,DOBfield,Adr1Field, Adr2Field,TownField, Password, Email, PostCodeField,PhoneNum;
    private NestedScrollView scrollview;
    private LinearLayout commentsLayout;
    private Button LoginBtn, addChild, RemoveChild , AgreeButton;
    private int counter = 5;
    private FirebaseAuth mAuth;
    String sessionId , OfflineMemSHMAID,ShmaIdsOnAppSHMAID;
    String usr_SHMAID,firstname,lastname,DOB,usr_email ,MobileNumber, usr_password, addr1,addr2,townfield,postcode,MembershipType, Status;
    DatabaseReference mDatabase;
    List<User> users = new ArrayList<>();
    //checkall fields on entry
    private List<EditText> lstTexts = new ArrayList<EditText>();
   //number of children that can be added
    private List<EditText> Children = new ArrayList<EditText>();
    private List<EditText> Spouse = new ArrayList<EditText>();
    private int i =1 ;

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
                    addTings("Spouse Full Name");
                    addTings("Spouse D.O.B");
                    addTings("Spouse Email");
                    addChildButtons();

                }else{
                    RemoveWifenChildrenDetails();
             }
            }
        });


    }




    private void addChildButtons(){
        addChild.setVisibility(View.VISIBLE);
        RemoveChild.setVisibility(View.VISIBLE);
        lblAddchild.setVisibility(View.VISIBLE);
        lblRemovechild.setVisibility(View.VISIBLE);
    }
    private void RemoveWifenChildrenDetails(){
        i = 1;
        for (EditText wifeDetails : Spouse) {
            commentsLayout.removeView(wifeDetails);
        }
        for (EditText childrenDetails : Children) {
            commentsLayout.removeView(childrenDetails);
        }
        addChild.setVisibility(View.GONE);
        RemoveChild.setVisibility(View.GONE);
        lblAddchild.setVisibility(View.GONE);
        lblRemovechild.setVisibility(View.GONE);

    }

public void AddChild(View v){
        addTings("Child no. " + i);
        addTings("Child D.O.B");
            i++;
}


    public void RemoveChild(View v){
     if (i>1){
         int latestname = Children.size()-1;
         int latestdob = Children.size()-2;
         EditText ChildrenName  = Children.get(latestname);
         EditText ChildrenDOB  = Children.get(latestdob);
         commentsLayout.removeView(ChildrenName);
         commentsLayout.removeView(ChildrenDOB);
         Children.remove(latestname);
         Children.remove(latestdob);
         i--;
     }else{
         PopupMessage("No Children Added");
     }

        }



private void addTings(String HintText){

     EditText rowTextView = new EditText(this);
     rowTextView.setInputType(InputType.TYPE_CLASS_TEXT);
    // set some properties of rowTextView or something
    rowTextView.setHint(HintText);
    // add the textview to the linearlayout
    commentsLayout.addView(rowTextView);
  //  commentsLayout.addView(rowTextView);
    //record of the edittextboxes
  if (HintText.contains("Spouse")){
            Spouse.add(rowTextView);
}else{
        Children.add(rowTextView);
}
    rowTextView.requestFocus();
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
            MobileNumber = PhoneNum.getText().toString().trim();
            if(familyswitch.isChecked()){
                MembershipType =  "Family";
            }else
                MembershipType =  "Single";  }
                Status = "Applied";


    }


    private boolean CheckDate(){
boolean fcheck, scheck = false;
boolean bothcheck = false;
        //check if date is in dd/MM/yyyy format
       fcheck = isValidFormat("dd/MM/yyyy",DOB);
       if (fcheck){
         scheck =  Over19();
       }else{
           PopupMessage("Date must be in dd/MM/yyyy Format");
       }
if ((fcheck && scheck)) {
    bothcheck = true;
}

       return bothcheck;
    }

    private boolean Over19(){
        boolean check = false;
        String dateparts[] = DOB.split("/");
        int year = Integer.valueOf(dateparts[2]);
         int month =Integer.valueOf(dateparts[1]) ;
         int day = Integer.valueOf(dateparts[0]);
        int age = getAge(year,month,day);
if (age >= 19){
    check = true;
}else{
    PopupMessage("You Must Be Over 19 To Register");
}
return check;
    }

    private Integer getAge(int year, int month, int day){
        Calendar dob = Calendar.getInstance();
        Calendar today = Calendar.getInstance();

        dob.set(year, month, day);

        int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);

     //   if (today.get(Calendar.DAY_OF_YEAR) < dob.get(Calendar.DAY_OF_YEAR)){
      //      age--;
      //  }


        Integer ageInt = new Integer(age);

        return ageInt;
    }

     public static boolean isValidFormat(String format, String value ) {
        LocalDateTime ldt = null;
        DateTimeFormatter fomatter = DateTimeFormatter.ofPattern(format, Locale.ENGLISH);

        try {
            ldt = LocalDateTime.parse(value, fomatter);
            String result = ldt.format(fomatter);
            return result.equals(value);
        } catch (DateTimeParseException e) {
            try {
                LocalDate ld = LocalDate.parse(value, fomatter);
                String result = ld.format(fomatter);
                return result.equals(value);
            } catch (DateTimeParseException exp) {
                try {
                    LocalTime lt = LocalTime.parse(value, fomatter);
                    String result = lt.format(fomatter);
                    return result.equals(value);
                } catch (DateTimeParseException e2) {
                    // Debugging purposes
                    //e2.printStackTrace();
                }
            }
        }

        return false;
    }

public void SetUpUIelements() {
    lblAddchild = findViewById(R.id.addchildlbl);
    lblRemovechild = findViewById(R.id.removechildlbl);
    addChild = findViewById(R.id.AddChild);
    RemoveChild = findViewById(R.id.RemoveChild);
    parentLayout = findViewById(R.id.TheConstraintLayout);
    commentsLayout= findViewById(R.id.LinearLayoutscr);
    familyswitch = findViewById(R.id.FamilySwitch);
    Notice = findViewById(R.id.MembersAreaTitle);
    Title = findViewById(R.id.Title);
    SHMAid = findViewById(R.id.SHMAfield);
    Password = findViewById(R.id.PasswordField);
    Email = findViewById(R.id.EmailField);
    DOBfield = findViewById(R.id.DobField);
    Adr1Field = findViewById(R.id.Address1Field);
    Adr2Field = findViewById(R.id.Address2Field);
    TownField = findViewById(R.id.TownField);
    PostCodeField = findViewById(R.id.PostCodeField) ;
    LoginBtn = findViewById(R.id.LoginButton);
    Forgotpwd = findViewById(R.id.Forgotpwd);
    scrollview = findViewById(R.id.nestedScrollView);
    FirstName = findViewById(R.id.firstName);
    LastName = findViewById(R.id.lastName);
    PhoneNum = findViewById(R.id.Phonenum);
    urlWebView = findViewById(R.id.PrivacyPolicy);
    AgreeButton = findViewById(R.id.AgreeButton);
    Progressbar = findViewById(R.id.Progressbar);
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


    public boolean checkAllTV(List<EditText> allTV){

        for(EditText tv : allTV){
            if(tv.getText().toString().equals("")||tv.getText().toString()==null )
             return false;
        }
        return true;
    }

    private void EverythingGone(){
        Notice.setVisibility(View.GONE);
        SHMAid.setVisibility(View.GONE);
        Email.setVisibility(View.GONE);
        Password.setVisibility(View.GONE);
        Title.setVisibility(View.GONE);
        Forgotpwd.setVisibility(View.GONE);
        familyswitch.setVisibility(View.GONE);
        LoginBtn.setVisibility(View.GONE);
        FirstName.setVisibility(View.GONE);
        DOBfield.setVisibility(View.GONE);
        LastName.setVisibility(View.GONE);
        Adr1Field.setVisibility(View.GONE);
        PhoneNum.setVisibility(View.GONE);
        Adr2Field.setVisibility(View.GONE);
        TownField.setVisibility(View.GONE);
        PostCodeField.setVisibility(View.GONE);
        addChild.setVisibility(View.GONE);
        urlWebView.setVisibility(View.GONE);
        AgreeButton.setVisibility(View.GONE);
        RemoveChild.setVisibility(View.GONE);
    }

    public void CorrectElements(){
        lblAddchild.setVisibility(View.GONE);
        lblRemovechild.setVisibility(View.GONE);
        addChild.setVisibility(View.GONE);
        RemoveChild.setVisibility(View.GONE);
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
                         }

    }

private void AddFieldsToList(){
    List<EditText> namesList;
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
        Snackbar mySnackbar;
        mySnackbar = Snackbar.make(parentLayout, Message, 2000);
        View sbView = mySnackbar.getView();
        sbView.setBackgroundColor(Color.RED);
        TextView mainTextView = (mySnackbar.getView()).findViewById(android.support.design.R.id.snackbar_text);
        mainTextView.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        mainTextView.setTextColor(Color.BLACK);
        mainTextView.setTextSize(24);
        InputMethodManager imm = (InputMethodManager)this.getSystemService(Activity.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(parentLayout.getWindowToken(), 0);
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
                      //sendUserDataNewMem();
                      Query query = mDatabase.child("offline_members").orderByKey().limitToLast(1);
                      query.addListenerForSingleValueEvent(new ValueEventListener() {
                          @Override
                          public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                              for (DataSnapshot childSnapshot: dataSnapshot.getChildren()) {
                                  OfflineMemSHMAID = childSnapshot.getKey();
                                  //usr_SHMAID =   String.valueOf(OfflineMemSHMAID);
                              }

                              checkSHMAidsonApp();

                          }

                          @Override
                          public void onCancelled(@NonNull DatabaseError databaseError) {

                          }
                      });
                  }

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


    }Register();


}

    @Override
    public void onBackPressed() {
        // Here you want to show the user a dialog box
       if (AgreeButton.getVisibility() == View.VISIBLE) {
           new AlertDialog.Builder(MemberArea.this)
                   .setTitle("Privacy Policy")
                   .setMessage("If you do not agree then your account will not be created")
                   .setPositiveButton("Agree", new DialogInterface.OnClickListener() {
                       public void onClick(DialogInterface dialog, int whichButton) {
                           // The user wants to leave - so dismiss the dialog and exit
                           CreateUserAccount();
                           dialog.dismiss();
                       }
                   }).setNegativeButton("Disagree", new DialogInterface.OnClickListener() {
               public void onClick(DialogInterface dialog, int whichButton) {
                   // The user is not sure, so you can exit or just stay
                   finish();
                   dialog.dismiss();
               }
           }).show();
       }else{
           super.onBackPressed();
       }

    }

private void PrivacyPolicy(){
    EverythingGone();
    AgreeButton.setVisibility(View.VISIBLE);
    urlWebView.setVisibility(View.VISIBLE);
    DownloadPolicy();

}
private void DownloadPolicy(){
    //urlWebView.setWebViewClient(new AppWebViewClients());
    urlWebView.getSettings().setJavaScriptEnabled(true);
    urlWebView.getSettings().setBuiltInZoomControls(true);
    urlWebView.getSettings().setUseWideViewPort(true);
    urlWebView.loadUrl("https://firebasestorage.googleapis.com/v0/b/shma-559f5.appspot.com/o/Privacy%20Policy%2FSHMAPrivacyPolicy.html?alt=media&token=0a15acd1-c098-4e1e-ad73-e03b31a36df4");

}

public void Agree(View v){

    CreateUserAccount();

}

private void Register( ){
    boolean empty = checkAllTV(lstTexts);
        if (sessionId.equals("ExistMemb")) {
        // usr_SHMAID = SHMAid.getText().toString().trim();
        //usr_email = Email.getText().toString().trim();
        // usr_password = Password.getText().toString().trim();
        if (empty == false) {
            PopupMessage("Please fill in all available fields");
        } else {

            Query query = mDatabase.child("offline_members").orderByKey().equalTo(SHMAid.getText().toString());
            query.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                    if (dataSnapshot.exists()) {
                        //check the shmaID then add the login details into the firebase members database table
                        Query  query = mDatabase.child("shmaIdsOnApp").orderByKey().equalTo(SHMAid.getText().toString());
                        query.addListenerForSingleValueEvent(new ValueEventListener() {
                            @Override
                            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                                if (dataSnapshot.exists()) {
                                    PopupMessage("This SHMA id is already registered");
                                } else {
                                   CheckEmailinUse();
                                }
                            }
                            @Override
                            public void onCancelled(@NonNull DatabaseError databaseError) {
                            }
                        });
                    }else{
                        PopupMessage("SHMA id Does Not Exist");
                    }
                }

                @Override
                public void onCancelled(@NonNull DatabaseError databaseError) {

                }
            });


        }

    }else if ((sessionId.equals("Newmemb"))) {
        //Brand New Member -> Send the details to our Offline database
        if (empty == false) {
            PopupMessage("Please fill in all available fields");
        }else if (CheckDate()){
            CheckEmailinUse();

        }

    }
}

private void CheckEmailinUse(){
          mAuth.fetchSignInMethodsForEmail(usr_email)
            .addOnCompleteListener(new OnCompleteListener<SignInMethodQueryResult>() {
                @Override
                public void onComplete(@NonNull Task<SignInMethodQueryResult> task) {
                    SignInMethodQueryResult result = task.getResult();
                    List<String> signInMethods = result.getSignInMethods();
if (signInMethods.size() > 0){
    PopupMessage("Email Already in Use");
}else{
    PrivacyPolicy();
}
                }
            });

}

private void CreateUserAccount(){
        EverythingGone();
        Progressbar.setVisibility(View.VISIBLE);
    mAuth.createUserWithEmailAndPassword(usr_email, usr_password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
        @Override
        public void onComplete(@NonNull Task<AuthResult> task) {

            if (task.isSuccessful()) {
             sendEmailVerification();

            } else {
                PopupMessage("Email Already in Use. Please try again");

            }
        }
    });
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
                    OpenWelcomePage("ExistMem");
                }else{
                    Toast.makeText(getApplicationContext(), "Empty snapshot", Toast.LENGTH_SHORT).show();
                }

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });
    }

    private void OpenWelcomePage(String type){
        finish();
        Intent intent = new Intent(getApplicationContext(), WelcomeMessage.class);
        intent.putExtra("TYPE",type);
        startActivity(intent);
    }

    private void sendChildrendata(){
        FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference myRef = firebaseDatabase.getReference("children").child(mAuth.getUid());

        for (i=0;i<Children.size();i=i+2){
            String Name = Children.get(i).getText().toString();
            String DOB = Children.get(i+1).getText().toString();
            Child younglings = new Child(Name,DOB);
            myRef.push().setValue(younglings);
        }


    }

    private void sendSpousedata(){
        FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference myRef = firebaseDatabase.getReference("spouse").child(mAuth.getUid());

            String fullName = Spouse.get(0).getText().toString().trim();
            String DOB = Spouse.get(1).getText().toString().trim();
            String spEmail = Spouse.get(2).getText().toString().trim();

        Spouse honey = new Spouse(fullName,DOB, spEmail);
        myRef.setValue(honey);
    }

    private void  checkSHMAidsonApp(){
          Query  query = mDatabase.child("shmaIdsOnApp").orderByKey().limitToLast(1);
                query.addListenerForSingleValueEvent(new ValueEventListener() {
                    @Override
                    public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                        for (DataSnapshot childSnapshot: dataSnapshot.getChildren()) {
                            ShmaIdsOnAppSHMAID = childSnapshot.getKey();
                        }

                        int  offlinemem =   Integer.valueOf(OfflineMemSHMAID);
                        int shmaonappid =  Integer.valueOf(ShmaIdsOnAppSHMAID);
                     int newSHMAid = Math.max( offlinemem,shmaonappid) + 1  ;
                       usr_SHMAID =   String.valueOf(newSHMAid);
                        sendUserDataNewMem();


                    }
                    @Override
                    public void onCancelled(@NonNull DatabaseError databaseError) {
                    }
                });


    }

      private void sendUserDataNewMem() {
          FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
          DatabaseReference myRef = firebaseDatabase.getReference("members").child(mAuth.getUid());
          User NEWusr_profile = new User(usr_SHMAID, firstname, lastname, DOB, usr_email, addr1,addr2,townfield,postcode,MobileNumber, MembershipType,Status);
          myRef.setValue(NEWusr_profile);

          if(!Spouse.isEmpty()){
              sendSpousedata();
          }
          if (!Children.isEmpty()){
              sendChildrendata();
          }

          OpenWelcomePage("NewMem");
    }
}

