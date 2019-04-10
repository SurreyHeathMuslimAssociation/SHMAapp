package com.shma.yusuf.shma;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
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
import com.android.volley.toolbox.JsonObjectRequest;
import com.squareup.picasso.Picasso;

import org.json.JSONException;
import org.json.JSONObject;

public class BusinessInfo extends AppCompatActivity {
RequestQueue requestQueue;
private String apiKey = "AIzaSyBChiGmhrrLkXDTX4Oxo5nsB4uG3WgGidM";
private String placeid ,URL,GlobalAdress, GlobalTitle ;
private ImageView strimage;
TextView phonenum, ShopTitle, Address, Rating, Type, OpenNow, Opentimes ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_business_info);
        Intent intent = getIntent();
        SetUpUIelements();
        BottomNavigationView BottomNav = findViewById(R.id.bottom_nav);
        BottomNav.setOnNavigationItemSelectedListener(navlistener);
        Menu menu = BottomNav.getMenu();
        MenuItem menuItem = menu.getItem(1);
        menuItem.setChecked(true);
        placeid = intent.getExtras().getString("PlaceID");
        URL =  "https://maps.googleapis.com/maps/api/place/details/json?placeid="+ placeid + "&fields=name,formatted_address,opening_hours,types,rating,formatted_phone_number&key="+apiKey;
        PlaceRequest(URL);
        phonenum.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialContactPhone(phonenum.getText().toString());
            }
        });

         }

    private void dialContactPhone(final String phoneNumber) {
        startActivity(new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phoneNumber, null)));
    }

    public void getStreetViewImage(){
        if (!GlobalAdress.equalsIgnoreCase("")){
            String splitadd[] = GlobalAdress.split(",");
            String modLoc = GlobalTitle +","+splitadd[0];
            String URL = "https://maps.googleapis.com/maps/api/streetview?size=400x400&location="+modLoc+"&fov=90&pitch=10&key="+ apiKey;
            Picasso.get().load(URL).into(strimage);
        }

    }

    public void Routeme(View view){
        Uri gmmIntentUri = Uri.parse("geo:0,0?q="+GlobalAdress);
        Intent mapIntent = new Intent(Intent.ACTION_VIEW, gmmIntentUri);
        mapIntent.setPackage("com.google.android.apps.maps");
        startActivity(mapIntent);
    }

private void PlaceRequest(String url){
//Request Queue Setup
    Cache cache = new DiskBasedCache(getCacheDir(), 1024 * 1024); // 1MB cap
// Set up the network to use HttpURLConnection as the HTTP client.
    Network network = new BasicNetwork(new HurlStack());
// Instantiate the RequestQueue with the cache and network.
    requestQueue = new RequestQueue(cache, network);
// Start the queue
    requestQueue.start();


// Formulate the prayertimes request and handle the response.

    JsonObjectRequest jsonRequest = new JsonObjectRequest(Request.Method.GET, url, null,
            new Response.Listener<JSONObject>() {
                @Override
                public void onResponse(JSONObject response) {
                    try {

                        JSONObject number = response.getJSONObject("result");
                        JSONObject openinfo = number.optJSONObject("opening_hours");
                       GlobalTitle= number.optString("name");
                        ShopTitle.setText(GlobalTitle);
                        phonenum.setText(number.optString("formatted_phone_number"));
                        GlobalAdress = number.optString("formatted_address");
                        Address.setText(GlobalAdress);
                        Rating.setText(number.optString("rating"));
                        //Type fix
                        String typeofBus = number.optString("types");
                        if (!typeofBus.equalsIgnoreCase("")){
                            String[] MyStrings =  typeofBus.split("\"");
                            typeofBus = MyStrings[1];

                            Type.setText(typeofBus);
                        }

                       //open now check
                        if(openinfo == null){

                        }else{

                       if (openinfo.optString("open_now").equalsIgnoreCase("true")){
                           OpenNow.setText("Yes");
                       }else if ((openinfo.optString("open_now").equalsIgnoreCase("false"))){
                           OpenNow.setText("No");
                       }
                       //opening times fix
                        String opentimes = openinfo.optString("weekday_text").replace("\"", "");
                        opentimes = opentimes.replace("[", "");
                        opentimes = opentimes.replace("]", "");

                        Opentimes.setText(opentimes);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    getStreetViewImage();
                    requestQueue.stop();
                }
            }, new Response.ErrorListener() {
        @Override
        public void onErrorResponse(VolleyError error) {
            Toast.makeText(getApplicationContext(), "No response from Places api", Toast.LENGTH_SHORT).show();
        }
    });
    requestQueue.add(jsonRequest);
}

    private void SetUpUIelements(){
        phonenum  = findViewById(R.id.PhoneNumber);
        ShopTitle = findViewById(R.id.BusinessTitle);
        Address = findViewById(R.id.Address);
        Rating = findViewById(R.id.Rating);
        Type = findViewById(R.id.Type);
        OpenNow = findViewById(R.id.OpenNow);
        Opentimes = findViewById(R.id.OpeningTimes);
        strimage = findViewById(R.id.ShopImage);
    }

    private BottomNavigationView.OnNavigationItemSelectedListener navlistener = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {

            switch (menuItem.getItemId()) {

                case R.id.nav_home:
                    Intent sendTo;
                    finish();
                    sendTo = new Intent(getApplicationContext(), MemberSpace.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;
                case R.id.nav_business:
                    finish();
                    sendTo = new Intent(getApplicationContext(), member_business.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;

                case R.id.nav_funeral:
                    finish();
                    sendTo = new Intent(getApplicationContext(), member_funeral.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);
                    break;
                case R.id.nav_profile:
                    finish();
                    sendTo = new Intent(getApplicationContext(), MemberProfile.class);
                    startActivity(sendTo);
                    overridePendingTransition(0, 0);

                    break;

            }

            return true;
        }
    };

}
