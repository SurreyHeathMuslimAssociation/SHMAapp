package com.shma.yusuf.shma;
import android.content.Intent;
import android.support.annotation.Nullable;
import android.support.design.widget.Snackbar;
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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CorporateArea extends AppCompatActivity {
    private TextView Surnametxt ;
    private TextView dobback ;
    private CalendarView theDOB ;
    private static final String TAG = "firebase check";
    private static String date = "";
    private static  String surname = "";
    private DatabaseReference mDatabase ;
    private List<User> users = new ArrayList<>();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_corporate_area);
        mDatabase = FirebaseDatabase.getInstance().getReference("member_search");
        Surnametxt = findViewById(R.id.SHMAid);
        dobback  = findViewById(R.id.DOBtitle);
        theDOB = findViewById(R.id.DOB);

        //way of doing it without the listener on the calendar view



       /* theDOB.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                date = (dayOfMonth + "/" + (month +1) +  "/" + year) ;
                Log.d(TAG, "onSelectedDayChange: " + date);
                //Log.d(TAG, "size of array list is  " + String.valueOf(users.size()) );
                }
                });*/







          }

    @Override
    public void onStart() {

        super.onStart();
          String result = "test unchanged";
      //  users = new ArrayList<>();
        readfromFirebase();


                   }

public void addtodatabase(String surname, String DOB){
        User ting = new User (surname, DOB) ;
        mDatabase.child("member_search").setValue(ting);
}

public void readfromFirebase(){
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
           /* for (User s : users) {
                Log.d(TAG, "each element " + s.getDOB() );
                Log.d(TAG, "each element " + s.getSurname() );
            }
            Log.d(TAG, "size of array list is  " + String.valueOf(users.size()) );*/
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {

        }
    });
}

    public void Searchdb(View view){
        Intent intent = new Intent(this, CorporateArea.class);
        //grab date at button press point
         SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        date = sdf.format(new Date(theDOB.getDate()));

        //loop through users to find the correct one if exists
        for (User s : users) {

            Snackbar mySnackbar;
            if (surname.equalsIgnoreCase(s.getSurname()) && date == s.getDOB()) {
                Log.d(TAG, "date entered is " + date + "surname entered is" + surname);
                mySnackbar = Snackbar.make(view, "VALID MEMBER", 4000);

            } else {
                mySnackbar = Snackbar.make(view, "INVALID MEMBER", 4000);
            }
                 mySnackbar.show();


        }


}

}
