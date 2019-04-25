package com.shma.yusuf.shma;

import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.TextView;

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
           //     Toast.makeText(getApplicationContext(), "Database Error", Toast.LENGTH_SHORT).show();
            }

        });

    }


    @Override
    public void onBackPressed() {
        // Here you want to show the user a dialog box
        new AlertDialog.Builder(member_funeral.this)
                .setTitle("Logout")
                .setMessage("Are you sure you want to logout?")
                .setPositiveButton("YES", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                        // The user wants to leave - so dismiss the dialog and exit
                        finish();
                        auth.signOut();
                        dialog.dismiss();
                    }
                }).setNegativeButton("NO", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                // The user is not sure, so you can exit or just stay
                dialog.dismiss();
            }
        }).show();

    }

    private void SetUpUIelements(){
        funeralContacts=  findViewById(R.id.funeralcontacts);
    }
    private void setToCustomGrid(){
        FuneralGridAdapter adapterViewAndroid = new FuneralGridAdapter(member_funeral.this, numbers,names);
        funeralContacts.setAdapter(adapterViewAndroid);
        funeralContacts.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String phoneNoFromGrid;
                phoneNoFromGrid = ((TextView)(view.findViewById(R.id.grid_content))).getText().toString();
                dialContactPhone(phoneNoFromGrid);
            }
        });
    }

    private void dialContactPhone(final String phoneNumber) {
        startActivity(new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phoneNumber, null)));
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
