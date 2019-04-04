package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
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

import java.lang.reflect.Member;

public class MemberProfile extends AppCompatActivity {
   private TextView SHMAID,firstname , surname , DOB;
   private Button logout;
   private FirebaseAuth auth = FirebaseAuth.getInstance();
   private FirebaseUser user;
   private FirebaseDatabase firebaseDatabase;

    private void SetUpUIelements(){
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
        BottomNavigationView BottomNav = findViewById(R.id.bottom_nav);
        BottomNav.setOnNavigationItemSelectedListener(navlistener);
        Menu menu = BottomNav.getMenu();
        MenuItem menuItem = menu.getItem(3);
        menuItem.setChecked(true);
        Toolbar myToolbar = findViewById(R.id.my_toolbar);
        setSupportActionBar(myToolbar);
        getSupportActionBar().setTitle("Profile");
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
                DOB.setText("DOB: " + userProfile.getDOB());

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }

        });



    }

    private BottomNavigationView.OnNavigationItemSelectedListener navlistener = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
            //Fragment selectedFragment = null;
            switch(menuItem.getItemId()){
                case R.id.nav_home:
                    Intent sendTo;
                    finish();
                    sendTo = new Intent(MemberProfile.this, MemberSpace.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;
                case R.id.nav_business:
                    finish();
                    sendTo = new Intent(MemberProfile.this, member_business.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;

                case R.id.nav_funeral:
                    finish();
                    sendTo = new Intent(MemberProfile.this, member_funeral.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;
                case R.id.nav_profile:
                    finish();

                    sendTo = new Intent(MemberProfile.this, MemberProfile.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;

            }
            //getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,selectedFragment).commit();

            return true;
        }
    };


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()){
            case R.id.logoutMenu: {
        Logout();
            }
        }
        return super.onOptionsItemSelected(item);
    }
}
