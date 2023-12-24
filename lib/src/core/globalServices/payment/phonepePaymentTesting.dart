import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:crypto/crypto.dart';
import "package:http/http.dart" as http;

class PhonePayPaymentScreen extends StatefulWidget {
  const PhonePayPaymentScreen({super.key});

  @override
  State<PhonePayPaymentScreen> createState() => _PhonePayPaymentScreenState();
}

class _PhonePayPaymentScreenState extends State<PhonePayPaymentScreen> {
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
  Object? result;

  checkStatus() async {
    String url =
        "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$transactionId";

    // String url =
    //     "https://apps-uat.phonepe.com/v3/transaction/$merchantId/$transactionId/status";

    //String tId = "T2312231951133052465147";

    String xVerifyString = "/pg/v1/status/$merchantId/$transactionId$saltKey";

    var xVerifyBytes = utf8.encode(xVerifyString);
    var xVerifyDigest = sha256.convert(xVerifyBytes).toString();
    String xVerify = "$xVerifyDigest###$saltIndex";

    Map<String, String> header = {
      "Content-Type": "application/json",
      "X-VERIFY": xVerify,
      "X-MERCHANT-ID": merchantId
    };

    await http.get(Uri.parse(url), headers: header).then((value) {
      var res = jsonDecode(value.body);
      print(res);
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
      "paymentInstrument": {"type": "PAY_PAGE"}
    };
    String base64body = base64.encode(utf8.encode(json.encode(requestBody)));
    checkSum =
        '${sha256.convert(utf8.encode(base64body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    print(checkSum);
    print(base64body + "        vineeth");
    return base64body;
  }

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

  void startPGTransaction() async {
    try {
      PhonePePaymentSdk.startPGTransaction(
              body, callback, checkSum, pgHeaders, apiEndPoint, "")
          .then((response) => {
                setState(() {
                  if (response != null) {
                    String status = response['status'].toString();
                    String error = response['error'].toString();
                    if (status == 'SUCCESS') {
                      result = "Flow Completed - Status: Success!";

                      checkStatus();
                    } else {
                      result =
                          "Flow Completed - Status: $status and Error: $error";
                    }
                  } else {
                    result = "Flow Incomplete";
                  }
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
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

  @override
  void initState() {
    initPhonePeSdk();
    body = getBody().toString();
    startPGTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
