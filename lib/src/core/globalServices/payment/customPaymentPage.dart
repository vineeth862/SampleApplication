import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:sample_application/src/core/globalServices/payment/upi_app.dart';

class CustomPaymentPage extends StatefulWidget {
  const CustomPaymentPage({super.key});

  @override
  State<CustomPaymentPage> createState() => _CustomPaymentPageState();
}

class _CustomPaymentPageState extends State<CustomPaymentPage> {
  Object? result;
  String environmentValue = 'UAT_SIM';
  String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
  String appId = '';
  String merchantId = 'PGTESTPAYUAT';
  bool enableLogging = true;
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String checkSum = "";
  String saltIndex = "1";
  String callback = "https://webhook.site/48673050-1c88-4cf3-b288-fda8c58470dd";

  String body = '';
  Map<String, String> headers = {};
  Map<String, String> pgHeaders = {};
  List<String> apiList = <String>['Container', 'PG'];
  List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];
  String apiEndPoint = "/pg/v1/pay";
  bool enableLogs = true;
  Map<dynamic, dynamic> status = {};
  List<UPIApp> upiApps = [];
  Map<String, String> logoPath = {
    "PhonePe":
        "https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/phonepe-logos-idzxSpanBR.png?alt=media&token=ccc904e5-6c05-45f8-ac00-53296c75ec7c",
    "CRED":
        "https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/cred-logos-iddmiY93-Y.jpeg?alt=media&token=cc06e619-45be-47a0-86b5-a830699eb74f",
    "GPay":
        "https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/7123945_logo_pay_google_gpay_icon.png?alt=media&token=c13cceb6-d6f4-468e-8265-ff3dc2852ec5"
  };

  void initPhonePeSdk() {
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
        .then((isInitialized) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $isInitialized';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  getInstalledUpiAppsForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getInstalledUpiAppsForAndroid()
          .then((apps) => {
                setState(() {
                  if (apps != null) {
                    Iterable l = json.decode(apps);
                    List<UPIApp> upiApps1 = List<UPIApp>.from(
                        l.map((model) => UPIApp.fromJson(model)));
                    String appString = '';
                    print(upiApps);
                    for (var element in upiApps1) {
                      appString += "${element.applicationName} ";
                      if (["GPay", "CRED", "PhonePe"]
                          .contains(element.applicationName)) {
                        element.imagePath =
                            logoPath[element.applicationName].toString();
                        upiApps.add(element);
                      }
                    }
                    result = 'Installed Upi Apps - $appString';
                    print(result);
                    setState(() {
                      upiApps = upiApps;
                    });
                    print(upiApps);
                  } else {
                    result = 'Installed Upi Apps - 0';
                  }
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    }
  }

  void handleError(error) {
    setState(() {
      if (error is Exception) {
        result = error.toString();
      } else {
        result = {"error": error};
      }
    });
  }

  getBody() {
    Map requestBody = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionId,
      "merchantUserId": "MUID123",
      "amount": 100,
      "callbackUrl": callback,
      "mobileNumber": "9999999999",
      "deviceContext": {"deviceOS": "ANDROID"},
      "paymentInstrument": {
        "type": "UPI_INTENT",
        "targetApp": "com.dreamplug.androidapp"
      }
    };
    String base64body = base64.encode(utf8.encode(json.encode(requestBody)));
    checkSum =
        '${sha256.convert(utf8.encode(base64body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    return base64body;
  }

  startPGTransaction() async {
    try {
      PhonePePaymentSdk.startPGTransaction(
              body, callback, checkSum, pgHeaders, apiEndPoint, "")
          .then((response) async {
        if (response?['status'] == 'SUCCESS') {
          print(response);
        }
        // updateStatus(
        //   'paymentStatus',
        //   response?['status'],
        // );
      }).catchError((error) {
        // updateStatus(
        //   'paymentStatus',
        //   'FAILURE',
        // );

        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      // updateStatus(
      //   'paymentStatus',
      //   'FAILURE',
      // );
      handleError(error);
    }
  }

  @override
  void initState() {
    initPhonePeSdk();
    body = getBody();
    //startPGTransaction();
    getInstalledUpiAppsForAndroid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 4 : 2,
                childAspectRatio: MediaQuery.of(context).size.width < 600
                    ? 1.7
                    : 1.8, // number of items in each row
                mainAxisSpacing: 4.0, // spacing between rows
                crossAxisSpacing: 20.0, // spacing between columns
              ),
              itemCount: upiApps
                  .length, //GET THE COUNT OF BOOKING DONE BY USER AND UPDATE HERE
              itemBuilder: (context, index) {
                if (upiApps[index].applicationName != null) {
                  return GestureDetector(
                    onTap: () {},
                    child: Image.network(upiApps[index].imagePath.toString()),
                  );
                  // Text(upiApps[index].applicationName.toString()),
                }
              })),
    );
  }
}
