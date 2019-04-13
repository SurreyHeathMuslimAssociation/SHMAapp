package com.shma.yusuf.shma;

import android.content.DialogInterface;
import android.content.Intent;
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

import com.android.volley.RequestQueue;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class member_business extends AppCompatActivity {
    private RequestQueue rq = null;
    private FirebaseAuth auth = FirebaseAuth.getInstance();
    private ArrayList<String>discounts = new ArrayList<>();
    private ArrayList<String>shopImage = new ArrayList<>();
    private ArrayList<String>PlaceIDs = new ArrayList<>();
    private List<BusinessDetails> CurrentBusinesses = new ArrayList<>();
    private GridView BusinessGridView;
    private DatabaseReference mDatabase ;
    private String sessionId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_business);
        sessionId= getIntent().getStringExtra("FromTheMain");
        BottomNavigationView BottomNav = findViewById(R.id.bottom_nav);
        if(sessionId != null && sessionId.equals("Main")){
            BottomNav.setVisibility(View.GONE);
        }else {
            BottomNav.setVisibility(View.VISIBLE);
            BottomNav.setOnNavigationItemSelectedListener(navlistener);
            Menu menu = BottomNav.getMenu();
            MenuItem menuItem = menu.getItem(1);
            menuItem.setChecked(true);
        }
        SetUpUIelements();
        mDatabase = FirebaseDatabase.getInstance().getReference("businesses");
                //Database listeners
        mDatabase .addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {

                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()){

                    BusinessDetails deet = postSnapshot.getValue(BusinessDetails.class);
                    deet.setPlaceID(postSnapshot.getKey());
                    CurrentBusinesses.add(deet);
                  //  Toast.makeText(getApplicationContext(), "output " + output, Toast.LENGTH_SHORT).show();
                }
                MakeThreeLists();
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });

    }

    @Override
    public void onBackPressed() {
        if(!sessionId.equals("Main")) {
            // Here you want to show the user a dialog box
            new AlertDialog.Builder(member_business.this)
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
        }else
        { finish();}
    }

private void MakeThreeLists(){

        for (BusinessDetails d : CurrentBusinesses){
            discounts.add(d.getDiscount());
           shopImage.add(d.getIconUrl());
            PlaceIDs.add(d.getPlaceID());
           }
setToCustomGrid();

}

    public RequestQueue getRq() {
        return rq;
    }

    public void setRq(RequestQueue rq) {
        this.rq = rq;
    }


      private void SetUpUIelements(){
        BusinessGridView=  findViewById(R.id.BusinessGridView);
    }

    @Override
    protected void onStop () {
        super.onStop();
        if (rq != null){
            rq.stop();
        }
    }
    private void setToCustomGrid(){
        BusinessGridAdapter adapterViewAndroid = new BusinessGridAdapter(member_business.this, discounts,shopImage,PlaceIDs, this);
        BusinessGridView.setAdapter(adapterViewAndroid);
        BusinessGridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                BusinessDetails deet =  CurrentBusinesses.get(position);
                Intent sendTo;
                sendTo = new Intent(member_business.this, BusinessInfo.class);
                //passing the placeid to the business info
                sendTo.putExtra("PlaceID",deet.getPlaceID());
                if(sessionId != null && sessionId.equals("Main")){
                    sendTo.putExtra("FromTheMain","Main");
                }
                startActivity(sendTo);

                   // Get the GridView selected/clicked item text
                //String selectedItem = parent.getItemAtPosition(position).toString();

            }
        });
    }

    private BottomNavigationView.OnNavigationItemSelectedListener navlistener = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {

            switch (menuItem.getItemId()) {

                case R.id.nav_home:
                    Intent sendTo;
                    finish();
                    sendTo = new Intent(member_business.this, MemberSpace.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;
                case R.id.nav_business:
                    finish();
                    sendTo = new Intent(member_business.this, member_business.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;

                case R.id.nav_funeral:
                    finish();
                    sendTo = new Intent(member_business.this, member_funeral.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;
                case R.id.nav_profile:
                    finish();
                    sendTo = new Intent(member_business.this, MemberProfile.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;

            }

            return true;
        }
    };
}
