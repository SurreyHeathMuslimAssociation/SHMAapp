package com.shma.yusuf.shma;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Cache;
import com.android.volley.Network;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.BasicNetwork;
import com.android.volley.toolbox.DiskBasedCache;
import com.android.volley.toolbox.HurlStack;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResponse;
import com.google.android.gms.location.SettingsClient;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.gson.JsonObject;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class MemberSpace extends AppCompatActivity {
    private TextView membershipNumber, liveDatenTime;
    private GridView PrayerView;
    private FirebaseAuth auth = FirebaseAuth.getInstance();
    private FirebaseUser user;
    private FirebaseDatabase firebaseDatabase;
    Calendar c = Calendar.getInstance();
    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm");
    String formattedDate = df.format(c.getTime());
    RequestQueue requestQueue;
    String currentLocation;
    FusedLocationProviderClient fusedLocationClient;
    private ArrayList<String> PrayerTimings = new ArrayList<String>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_space);
        SetUpUIelements();
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this);
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED || ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            currentLocation = "No Permission granted";
        }else{

            fusedLocationClient.getLastLocation()
                    .addOnSuccessListener(this, new OnSuccessListener<Location>() {
                        @Override
                        public void onSuccess(Location location) {
                           // Got last known location. In some rare situations this can be null.
                            if (location != null) {
                                // Logic to handle location object
                               // currentLocation = location.toString();
                                currentLocation = "latitude="+ String.valueOf(location.getLatitude()) + "& longitude=" + String.valueOf( location.getLongitude()) ;
                                PrayerTimes(currentLocation);
                            }
                        }
                    });


        }



        BottomNavigationView BottomNav = findViewById(R.id.bottom_nav);
        BottomNav.setOnNavigationItemSelectedListener(navlistener);
        Menu menu = BottomNav.getMenu();
        MenuItem menuItem = menu.getItem(0);
        menuItem.setChecked(true);

        firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference databaseReference = firebaseDatabase.getReference("members").child(auth.getUid());
        databaseReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                User userProfile = dataSnapshot.getValue(User.class);

                membershipNumber.setText("Membership Number: " + userProfile.getShmaId());
                liveDatenTime.setText(formattedDate);

            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {
                Toast.makeText(getApplicationContext(), "Connection lost", Toast.LENGTH_SHORT).show();
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
                    sendTo = new Intent(MemberSpace.this, MemberSpace.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;
                case R.id.nav_business:
                    finish();
                    sendTo = new Intent(MemberSpace.this, member_business.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;

                case R.id.nav_funeral:
                    finish();
                    sendTo = new Intent(MemberSpace.this, member_funeral.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;
                case R.id.nav_profile:
                    finish();

                    sendTo = new Intent(MemberSpace.this, MemberProfile.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;

            }
            //getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,selectedFragment).commit();

            return true;
        }
    };


private void setToCustomGrid(){
     GridViewAdapter adapterViewAndroid = new GridViewAdapter(MemberSpace.this, PrayerTimings);
     PrayerView.setAdapter(adapterViewAndroid);
}

    private void PrayerTimes(String location) {
        String shortdate = formattedDate.substring(0,10);
        String url ="http://api.aladhan.com/v1/timings/" + shortdate + "?" + location + "&method=2";
//Request Queue Setup
        Cache cache = new DiskBasedCache(getCacheDir(), 1024 * 1024); // 1MB cap
// Set up the network to use HttpURLConnection as the HTTP client.
        Network network = new BasicNetwork(new HurlStack());
// Instantiate the RequestQueue with the cache and network.
        requestQueue = new RequestQueue(cache, network);
// Start the queue
        requestQueue.start();


// Formulate the prayertimes request and handle the response.

        JsonObjectRequest jsonRequest = new JsonObjectRequest(Request.Method.GET,url,null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            JSONObject jsonArray = response.getJSONObject("data");
                            JSONObject timings = jsonArray.getJSONObject("timings");
                            PrayerTimings.add(timings.optString("Fajr"));
                            PrayerTimings.add(timings.optString("Sunrise"));
                            PrayerTimings.add(timings.optString("Dhuhr"));
                            PrayerTimings.add(timings.optString("Asr"));
                            PrayerTimings.add(timings.optString("Maghrib"));
                            PrayerTimings.add(timings.optString("Isha"));
                            PrayerTimings.add(timings.optString("Imsak"));
                            PrayerTimings.add(timings.optString("Midnight"));
                            //    Toast.makeText(getApplicationContext(), "Prayer times Loaded", Toast.LENGTH_SHORT).show();


                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                        setToCustomGrid();
                      //  The above code showGridview
                        requestQueue.stop();
                    }

                },
                new Response.ErrorListener(){
            @Override
                    public void onErrorResponse(VolleyError error){
                Toast.makeText(getApplicationContext(), "No response from Prayer times api", Toast.LENGTH_SHORT).show();
            }
                });

// Add the request to the RequestQueue.
        requestQueue.add(jsonRequest);

     }


    private void SetUpUIelements(){
        membershipNumber  = findViewById(R.id.mbno);
        liveDatenTime =  findViewById(R.id.livedatentime);
        PrayerView = findViewById(R.id.prayerView);
    }

}
