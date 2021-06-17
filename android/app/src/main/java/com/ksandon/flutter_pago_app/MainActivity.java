package com.ksandon.flutter_pago_app;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import lib.visanet.com.pe.visanetlib.VisaNet;
import lib.visanet.com.pe.visanetlib.presentation.custom.VisaNetViewAuthorizationCustom;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "com.ksandon.niubiz/flutterNiubizSdk";
  private MethodChannel.Result response;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (call, result) -> {
              if(call.method.equals("niubizBridgeSDK")) {
                response = result;
                try {
                  niubizBridgeSDK(call);
                } catch (Exception e) {
                  Toast toast = Toast.makeText(getApplicationContext(), e.getMessage(), Toast.LENGTH_LONG);
                  toast.show();
                }
              }
            }
    );
  }

  private void niubizBridgeSDK(MethodCall call) {
    HashMap<String, String> mdd = call.argument("mdd");
    HashMap<String, String> config = call.argument("config");

    // SDK configuration
    Map<String, Object> data = new HashMap<>();
    data.put(VisaNet.VISANET_SECURITY_TOKEN, config.get("token"));
    data.put(VisaNet.VISANET_CHANNEL, VisaNet.Channel.MOBILE);
    data.put(VisaNet.VISANET_COUNTABLE, true);
    data.put(VisaNet.VISANET_MERCHANT, config.get("merchantID"));
    data.put(VisaNet.VISANET_PURCHASE_NUMBER, config.get("purchase"));
    data.put(VisaNet.VISANET_AMOUNT, config.get("amount"));
    data.put(VisaNet.VISANET_MDD, mdd);

    data.put(VisaNet.VISANET_REGISTER_NAME, config.get("name"));
    data.put(VisaNet.VISANET_REGISTER_LASTNAME, config.get("lastname"));
    data.put(VisaNet.VISANET_REGISTER_EMAIL, config.get("email"));

    data.put(VisaNet.VISANET_ENDPOINT_URL, config.get("endpoint") + "/");
    data.put(VisaNet.VISANET_CERTIFICATE_HOST, config.get("endpoint"));
    data.put(VisaNet.VISANET_CERTIFICATE_PIN, "sha256/" + config.get("pin"));
    VisaNetViewAuthorizationCustom custom = new VisaNetViewAuthorizationCustom();
    custom.setLogoImage(R.drawable.logo);

    custom.setButtonColorMerchant(R.color.visanet_black);
    try {
      VisaNet.authorization(this, data, custom);
    } catch (Exception e) {
      Toast toast = Toast.makeText(getApplicationContext(), e.getMessage(), Toast.LENGTH_LONG);
      toast.show();
    }
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    String niubizResponse = "";
    if (requestCode == VisaNet.VISANET_AUTHORIZATION) {
      if (data != null) {
        if (resultCode == RESULT_OK) {
          niubizResponse = data.getExtras().getString("keySuccess");
        } else {
          niubizResponse = data.getExtras().getString("keyError");
        }
      } else {
        Toast toast1 = Toast.makeText(getApplicationContext(), "Cancel...", Toast.LENGTH_LONG);
        toast1.show();
      }
    }
    response.success(niubizResponse);
  }


}
