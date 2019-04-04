package com.shma.yusuf.shma;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.GridView;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class member_funeral extends AppCompatActivity {
    private GridView funeralContacts;
    private FirebaseAuth auth = FirebaseAuth.getInstance();
    private FirebaseDatabase firebaseDatabase;
    private  ArrayList<String> names = new ArrayList<String>();
    private  ArrayList<String> numbers = new ArrayList<String>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_funeral);
        BottomNavigationView BottomNav = findViewById(R.id.bottom_nav);
        BottomNav.setOnNavigationItemSelectedListener(navlistener);
        Menu menu = BottomNav.getMenu();
        MenuItem menuItem = menu.getItem(2);
        menuItem.setChecked(true);
        SetUpUIelements();
        //database reads
        firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference databaseReference = firebaseDatabase.getReference("funeral");
       //Database listeners
        databaseReference .addValueEventListener(new ValueEventListener(){
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
               // User userProfile = dataSnapshot.getValue(User.class);
                for (DataSnapshot m : dataSnapshot.getChildren()) {
                    numbers.add(String.valueOf(m.getValue()));
                    names.add(String.valueOf(m.getKey()));

                }

setToCustomGrid();



            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {
                Toast.makeText(getApplicationContext(), "Database Error", Toast.LENGTH_SHORT).show();
            }

        });

    }

    private void SetUpUIelements(){
        funeralContacts=  findViewById(R.id.funeralcontacts);
    }
    private void setToCustomGrid(){
        FuneralGridAdapter adapterViewAndroid = new FuneralGridAdapter(member_funeral.this, numbers,names);
        funeralContacts.setAdapter(adapterViewAndroid);
    }

    private BottomNavigationView.OnNavigationItemSelectedListener navlistener = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {

            switch (menuItem.getItemId()) {
                case R.id.nav_home:
                    Intent sendTo;
                    finish();
                    sendTo = new Intent(member_funeral.this, MemberSpace.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;
                case R.id.nav_business:
                    finish();
                    sendTo = new Intent(member_funeral.this, member_business.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;

                case R.id.nav_funeral:
                    finish();
                    sendTo = new Intent(member_funeral.this, member_funeral.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;
                case R.id.nav_profile:
                    finish();

                    sendTo = new Intent(member_funeral.this, MemberProfile.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;

            }
            //getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,selectedFragment).commit();

            return true;
        }
    };
}
