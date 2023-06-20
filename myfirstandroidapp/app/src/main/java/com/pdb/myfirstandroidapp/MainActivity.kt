package com.pdb.myfirstandroidapp

import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.ComponentActivity


// 화면 제어
// option + enter => auto import
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val image1 = findViewById<ImageView>(R.id.bts_image_1)
        image1.setOnClickListener {
            Toast.makeText(this, "1번 클릭 완료", Toast.LENGTH_LONG).show()


            val intent = Intent(this, Bts1Activity::class.java)
            startActivity(intent)

        }


        val image2 = findViewById<ImageView>(R.id.bts_image_2)
        image2.setOnClickListener {
            Toast.makeText(this, "2번 클릭 완료", Toast.LENGTH_LONG).show()
            val intent = Intent(this, Bts2Acitivity::class.java)
            startActivity(intent)
        }
    }
}
