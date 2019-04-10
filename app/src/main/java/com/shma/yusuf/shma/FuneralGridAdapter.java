package com.shma.yusuf.shma;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

public class FuneralGridAdapter extends BaseAdapter {
    private Context mContext;
    private ArrayList<String> ContactNames;
    private ArrayList<String> Numbers;


    public FuneralGridAdapter (Context context, ArrayList<String> numbers, ArrayList<String> ContactNames){
        this.mContext = context;
        this.Numbers = numbers;
        this.ContactNames = ContactNames;

    }

    @Override
    public int getCount() {
        return Numbers.size();
    }

    @Override
    public Object getItem(int position) {
        return Numbers.get(position);
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
        if(convertView==null)
        {
            gridViewAndroid = inflater.inflate(R.layout.funeralgrid, null);
            TextView Names = gridViewAndroid.findViewById(R.id.grid_label);
            final TextView lNumbers = gridViewAndroid.findViewById(R.id.grid_content);
            Names.setText(ContactNames.get(position));
            lNumbers.setText(Numbers.get(position));

        }
        else{

        }
        return gridViewAndroid;
    }

}
