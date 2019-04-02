package com.shma.yusuf.shma;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.TextView;

import java.util.ArrayList;

public class GridViewAdapter extends BaseAdapter {

    private Context mContext;
    private String[] PrayerLabels =  { "Fajr", "Zohur", "Asr", "Magrib", "Isha" } ;
    private String[] PrayerTimes;

    public GridViewAdapter (Context context, String[] PrayerTimes){
        this.mContext = context;
        this.PrayerTimes = PrayerTimes;
    }

    @Override
    public int getCount() {
        return 0;
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View gridViewAndroid;
        LayoutInflater inflater = (LayoutInflater) mContext
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        if (convertView == null) {

            gridViewAndroid = new View(mContext);
            gridViewAndroid = inflater.inflate(R.layout.prayertimesgrid, null);
            TextView Labels = gridViewAndroid.findViewById(R.id.grid_label);
            TextView PrayerTimesOnScreen = gridViewAndroid.findViewById(R.id.grid_prayertime);
           Labels.setText(PrayerLabels[position]);
            PrayerTimesOnScreen.setText(PrayerTimes[position]);

        } else {
            gridViewAndroid = convertView;
        }

        return gridViewAndroid;
    }
}
