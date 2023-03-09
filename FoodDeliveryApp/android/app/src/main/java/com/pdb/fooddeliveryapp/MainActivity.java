package com.pdb.fooddeliveryapp;

import com.facebook.react.ReactActivity;
//onme
import android.os.Bundle;

import org.devio.rn.splashscreen.SplashScreen; 

public class MainActivity extends ReactActivity {

  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
    return "FoodDeliveryApp";
  }
  //onme
  @Override
  protected void onCreate(Bundle savedInstanceState) {
  SplashScreen.show(this);
  super.onCreate(null);
  }
  //about navermap
  // @Override
  //     public void onCreate() {
  //         super.onCreate();
  //         NaverMapSdk.getInstance(this).setClient(
  //           new NaverMapSdk.NaverCloudPlatformClient("x49sgtunyt"));
  //   }
}
