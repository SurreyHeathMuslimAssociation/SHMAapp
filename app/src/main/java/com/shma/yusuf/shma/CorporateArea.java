package com.shma.yusuf.shma;
import android.app.DatePickerDialog;

import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.support.annotation.Nullable;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.TextView;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class CorporateArea extends AppCompatActivity {
    private TextView Surnametxt ;
    private TextView dobback ;
    private Button mybutton;
    private static final String TAG = "firebase check";
    private static String date = "";
    private static  String surname = "";
    private DatabaseReference mDatabase ;
    private List<User> users = new ArrayList<>();
    private List<String>SHMAid = new ArrayList<>();
    private DatePickerDialog.OnDateSetListener mDateSetListener;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
       setContentView(R.layout.activity_corporate_area);
        final View parentLayout = findViewById(android.R.id.content);
        mDatabase = FirebaseDatabase.getInstance().getReference("member_search");
        Surnametxt = findViewById(R.id.SHMAid);
        dobback  = findViewById(R.id.DOBtitle);
        mybutton = findViewById(R.id.searchme);
       mybutton.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View v) {
               Calendar cal = Calendar.getInstance();
               int year = cal.get(Calendar.YEAR);
               int month = cal.get(Calendar.MONTH);
               int day = cal.get(Calendar.DAY_OF_MONTH);

               DatePickerDialog dialog = new DatePickerDialog(
                       CorporateArea.this,
                       android.R.style.Theme_Holo_Light_Dialog_MinWidth,
                       mDateSetListener,
                       day,month,year);
               dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
               dialog.updateDate(1950,01,01);
               dialog.show();
           }

    });
//
        mDateSetListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int year, int month, int day) {

                //Log.d(TAG, "onDateSet: mm/dd/yyy: " + month + "/" + day + "/" + year);
                Calendar calendar = Calendar.getInstance();
                calendar.set(year, month, day);
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                date = sdf.format(calendar.getTime());
                surname = Surnametxt.getText().toString();
                // Log.d(TAG, "the date " + date);
                 Snackbar mySnackbar;

                for (User s : users) {

                   // Log.d(TAG, "date user " + date + "date arraylist" + s.getDOB());
                    //Log.d(TAG, "surname user " + surname + "arraylist surnmae" + s.getLastName());

                    if (surname.equalsIgnoreCase(s.getLastName()) && date.equals(s.getDOB())) {
                        SHMAid.add(s.getShmaId());
                    }
                } //end of for loop
                //Log.d(TAG, "size is" + SHMAid.size());
                if ( SHMAid.size() == 1) {
                    mySnackbar = Snackbar.make(parentLayout, "Valid Member with ID of " + SHMAid.get(0), 6000);
                    mySnackbar.getView().setBackgroundColor(Color.GREEN);
                } else if (SHMAid.size() > 1) {
                    mySnackbar = Snackbar.make(parentLayout, "Valid Members, ID's: " + SHMAid.toString(), 6000);
                    mySnackbar.getView().setBackgroundColor(Color.GREEN);
                } else {
                    mySnackbar = Snackbar.make(parentLayout, "Invalid Member", 6000);
                    mySnackbar.getView().setBackgroundColor(Color.RED);
                }
                TextView mainTextView = (mySnackbar.getView()).findViewById(android.support.design.R.id.snackbar_text);
                mainTextView.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
                mainTextView.setTextColor(Color.BLACK);
                mainTextView.setTextSize(24);
                mySnackbar.show();
                SHMAid.clear();

            }
        };
    }

   @Override
    public void onStart() {

        super.onStart();
          String result = "test unchanged";
      //  users = new ArrayList<>();

        readfromFirebase();


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
                usersdb.setShmaId(postSnapshot.getKey());
//                //PostSnapshot key is the member id -> has to be added separately of creating ann user
//                Log.d(TAG, "each key " +   );
                users.add(usersdb);
            }
           /*for (User s : users) {
                Log.d(TAG, "each element " + s.getId() );
                Log.d(TAG, "each element " + s.getDOB() );
                Log.d(TAG, "each element " + s.getFirstName());
                Log.d(TAG, "each element " + s.getLastName() );
            }
            Log.d(TAG, "size of array list is  " + String.valueOf(users.size()) );*/
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {

        }
    });
}



}
