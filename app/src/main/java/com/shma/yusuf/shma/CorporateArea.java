package com.shma.yusuf.shma;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.CalendarView;
import android.widget.TextView;

public class CorporateArea extends AppCompatActivity {

    private TextView dobback ;
    private CalendarView theDOB ;
    private static final String TAG = "DOB chooser";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_corporate_area);
        dobback = findViewById(R.id.DOBtitle);
        theDOB = findViewById(R.id.DOB);
        theDOB.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                String date = ("You were born on "+dayOfMonth + "/" + (month +1) +  "/" + year) ;
                Log.d(TAG, "onSelectedDayChange: " + date);
                dobback.setText(date);
            }
        });

    }
}
