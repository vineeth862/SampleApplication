import 'dart:convert';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:crypto/crypto.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:sample_application/src/Home/models/order/payment.dart';
import 'package:sample_application/src/core/Provider/selected_order_provider.dart';
import 'package:sample_application/src/core/Provider/selected_test_provider.dart';

import '../../../Home/models/order/order.dart';
import '../../../Home/order_tracker/orderTracker_progress.dart';

class PaymentService {
  PaymentService();
  // Function(Payment payment) payment;
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
  //  payment( Payment(
  //         amount: 0,
  //         transactionId: '',
  //         brn: '',
  //         merchantId: '',
  //         merchantTransactionId: '',
  //         paymentMode: '',
  //         pgTransactionId: '',
  //         status: false,
  //         statusLabel: ''););
  checkStatus(SelectedOrderState selectedOrder, SelectedTestState selectedTest,
      Order order) {
    String url =
        "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$transactionId";

    String xVerifyString = "/pg/v1/status/$merchantId/$transactionId$saltKey";

    Map<String, dynamic> result = {};

    var xVerifyBytes = utf8.encode(xVerifyString);
    var xVerifyDigest = sha256.convert(xVerifyBytes).toString();
    String xVerify = "$xVerifyDigest###$saltIndex";

    Map<String, String> header = {
      "Content-Type": "application/json",
      "X-VERIFY": xVerify,
      "X-MERCHANT-ID": merchantId
    };

    http.get(Uri.parse(url), headers: header).then((value) async {
      if (value.body != null && value.body != "") {
        var res = jsonDecode(value.body);
        result = res;

        order.payment == null
            ? order.payment = [Payment.fromJson(result)]
            : order.payment?.add(Payment.fromJson(result));
        order.statusCode = 2;
        order.statusLabel = "Order Placed";
        selectedOrder.setOrder = order;
        var tempOrder = json.decode(json.encode(order));
        selectedOrder.setOrder = order;

        if (order.orderNumber != null) {
          await selectedOrder.createOrder();
          // setState(() {
          selectedOrder.resetOrder();
          selectedTest.removeAllTest();
          selectedTest.removeAllPackage();
          // });
        }
        Get.offAll(OrderTrackingScreen(order: Order.fromJson(tempOrder)));

        // payment = Rx(Payment.fromJson(result));
      }
    });
    // return await result;
  }

  connect() async {
    body = getBody().toString();
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
        .then((isInitialized) {
      updateStatus('connection', true);
    }).catchError((error) {
      updateStatus('connection', false);
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
    return base64body;
  }

  startPGTransaction(SelectedOrderState selectedOrder,
      SelectedTestState selectedTest, Order order) async {
    try {
      PhonePePaymentSdk.startPGTransaction(
              body, callback, checkSum, pgHeaders, apiEndPoint, "")
          .then((response) async {
        if (response?['status'] == 'SUCCESS') {
          checkStatus(selectedOrder, selectedTest, order);
        }
        updateStatus(
          'paymentStatus',
          response?['status'],
        );
      }).catchError((error) {
        updateStatus(
          'paymentStatus',
          'FAILURE',
        );
      });
    } catch (error) {
      updateStatus(
        'paymentStatus',
        'FAILURE',
      );
    }
  }

  updateStatus(key, value) {
    status[key] = value;
  }
}
