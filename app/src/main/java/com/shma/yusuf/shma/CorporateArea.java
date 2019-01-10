package com.shma.yusuf.shma;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.CalendarView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class CorporateArea extends AppCompatActivity {
    private TextView Surnametxt ;
    private TextView dobback ;
    private CalendarView theDOB ;
    private static final String TAG = "firebase check";
       private DatabaseReference mDatabase ;
    private List<User> users = new ArrayList<>();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_corporate_area);
        mDatabase = FirebaseDatabase.getInstance().getReference("member_search");

        checkfields();


          }

    @Override
    public void onStart() {

        super.onStart();
          String result = "test unchanged";
      //  users = new ArrayList<>();

       mDatabase.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {




                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {
                    //getting artist
                    String rs = String.valueOf(postSnapshot.exists());
                  //  Log.d(TAG, "over here"+ rs  ); //comes back as true -> there is data
                    User usersdb = postSnapshot.getValue(User.class);

                    users.add(usersdb);
                  }
                for (User s : users) {
                    Log.d(TAG, "each element " + s.getDOB() );
                    Log.d(TAG, "each element " + s.getSurname() );
                }
                Log.d(TAG, "size of array list is  " + String.valueOf(users.size()) );
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

                   }

public void addtodatabase(String surname, String DOB){
        User ting = new User (surname, DOB) ;
        mDatabase.child("member_search").setValue(ting);
}

public void checkfields( ){
    Surnametxt = findViewById(R.id.SHMAid);
    dobback  = findViewById(R.id.DOBtitle);
    theDOB = findViewById(R.id.DOB);
    theDOB.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
        @Override
        public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
            String date = (dayOfMonth + "/" + (month +1) +  "/" + year) ;
            Log.d(TAG, "onSelectedDayChange: " + date);
            Log.d(TAG, "size of array list is  " + String.valueOf(users.size()) );
        }
    });


}

}
