package com.shma.yusuf.shma;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

public class BusinessGridAdapter extends BaseAdapter  {

    private Context mContext;
    private ArrayList<String> ShopImage;
    private ArrayList<String> Titles;


    public BusinessGridAdapter(Context context, ArrayList<String> Discounts, ArrayList<String> ShopImage) {
        this.mContext = context;
        this.Titles = Discounts;
        this.ShopImage = ShopImage;
    }

    @Override
    public int getCount() {
        return Titles.size();
    }

    @Override
    public Object getItem(int position) {
        return Titles.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View gridViewAndroid = convertView;

        LayoutInflater inflater = (LayoutInflater) mContext
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if (convertView == null) {
            gridViewAndroid = inflater.inflate(R.layout.businessgrid, null);
            TextView Labels = gridViewAndroid.findViewById(R.id.grid_label);
           ImageView pic = gridViewAndroid.findViewById(R.id.ShopLogo);


            new DownloadImageFromInternet(pic)
                    .execute(ShopImage.get(position));


            Labels.setText(Titles.get(position));
        }

        return gridViewAndroid;
    }

}