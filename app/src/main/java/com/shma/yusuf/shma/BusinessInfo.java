package com.shma.yusuf.shma;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
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
import com.google.android.gms.common.api.ApiException;
import com.google.android.libraries.places.api.Places;
import com.google.android.libraries.places.api.model.Place;
import com.google.android.libraries.places.api.net.FetchPlaceRequest;
import com.google.android.libraries.places.api.net.PlacesClient;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.List;

public class BusinessInfo extends AppCompatActivity {
    RequestQueue requestQueue;
private String apiKey = "AIzaSyBChiGmhrrLkXDTX4Oxo5nsB4uG3WgGidM";
private String placeid ;
private String URL ;
TextView phonenum, ShopTitle, Address, Rating, Type, OpenNow, Opentimes ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_business_info);
        Intent intent = getIntent();
        SetUpUIelements();
        // Initialize Places.
        Places.initialize(getApplicationContext(), apiKey);
        // Create a new Places client instance.
        PlacesClient placesClient = Places.createClient(this);
        placeid = intent.getExtras().getString("PlaceID");
        URL =  "https://maps.googleapis.com/maps/api/place/details/json?placeid="+ placeid + "&fields=name,formatted_address,opening_hours,types,rating,formatted_phone_number&key="+apiKey;
        PlaceRequest(URL);


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
                        ShopTitle.setText(number.optString("name"));
                        phonenum.setText(number.optString("formatted_phone_number"));
                        Address.setText(number.optString("formatted_address"));
                        Rating.setText(number.optString("rating"));
                        Type.setText(number.optString("types"));
                        OpenNow.setText(number.optString("open_now"));
                        Opentimes.setText(number.optString("opening_hours"));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

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
    }

}
