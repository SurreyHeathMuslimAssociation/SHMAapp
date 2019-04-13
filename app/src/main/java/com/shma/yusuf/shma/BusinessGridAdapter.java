package com.shma.yusuf.shma;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class BusinessGridAdapter extends BaseAdapter  {
    private RequestQueue requestQueue = null;
    private Context mContext;
    private ArrayList<String> ShopImage;
    private ArrayList<String> Discounts;
    private ArrayList<String>PlaceIDs;
    private ArrayList<String> order = new ArrayList<>();
    private Map<Integer, View> check = new HashMap<Integer, View>();
    private member_business mb = null;

//multiple error values detected from the getView method therefore used a hashmap thanks to papa

    public BusinessGridAdapter(Context context, ArrayList<String> Discounts, ArrayList<String> ShopImage,ArrayList<String> PlaceIDs, member_business mb) {
        this.mContext = context;
        this.Discounts = Discounts;
        this.ShopImage = ShopImage;
        this.PlaceIDs = PlaceIDs;
        this.mb = mb;
    }

    @Override
    public int getCount() {
        return Discounts.size();
    }

    @Override
    public Object getItem(int position) {
        return Discounts.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
       // View gridViewAndroid = convertView;
        if (check.get(position) == null){

            LayoutInflater inflater = (LayoutInflater) mContext
                    .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            String p= String.valueOf(position);
            order.add(p);
            Log.w("orderArraylist", order.toString());
            if (convertView == null)  {
                convertView = inflater.inflate(R.layout.businessgrid, null);
                check.put(position, convertView);
                TextView Labels = convertView.findViewById(R.id.grid_label);
                ImageView pic = convertView.findViewById(R.id.ShopLogo);
                Picasso.get().load(ShopImage.get(position)).into(pic);
                Labels.setText(Discounts.get(position) +" Off");
                PlaceRequest(convertView,PlaceIDs.get(position));
            }
        } else {
            convertView = check.get(position);
        }

        return convertView;
    }

    private void PlaceRequest(final View gridview, String placeid){
//Request Queue Setup
        Cache cache = new DiskBasedCache(mContext.getCacheDir(), 2024 * 2024); // 1MB cap
// Set up the network to use HttpURLConnection as the HTTP client.
        Network network = new BasicNetwork(new HurlStack());
// Instantiate the RequestQueue with the cache and network.
        requestQueue = new RequestQueue(cache, network);
// Start the queue
        requestQueue.start();
        String URL =  "https://maps.googleapis.com/maps/api/place/details/json?placeid="+ placeid + "&fields=name&key=AIzaSyBChiGmhrrLkXDTX4Oxo5nsB4uG3WgGidM";
// Formulate the prayertimes request and handle the response.
    mb.setRq(requestQueue);
        JsonObjectRequest jsonRequest = new JsonObjectRequest(Request.Method.GET, URL, null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            TextView BusName = gridview.findViewById(R.id.BusinessName);
                            JSONObject number = response.getJSONObject("result");
                            BusName.setText(number.optString("name"));



                        } catch (JSONException e) {
                            e.printStackTrace();
                        }

                        // requestQueue.stop();

                    } }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(mContext, "No response from Places api", Toast.LENGTH_SHORT).show();
            }

        });
        requestQueue.add(jsonRequest);
    }

    public RequestQueue getRequestQueue() {
        return requestQueue;
    }

}