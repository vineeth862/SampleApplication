import 'package:flutter/material.dart';
import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/services.dart';

class paymentScreen1 extends StatefulWidget {
  const paymentScreen1({super.key});

  @override
  State<paymentScreen1> createState() => _paymentScreen1State();
}

class _paymentScreen1State extends State<paymentScreen1> {
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await CcAvenue.cCAvenueInit(
          transUrl: 'https://test.ccavenue.com/transaction/initTrans',
          accessCode: 'AVCU18KJ84AN82UCNA',
          amount: '10',
          cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          currencyType: 'INR',
          merchantId: '2910641',
          orderId: '519',
          redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          rsaKeyUrl: 'https://test.ccavenue.com/transaction/jsp/GetRSA.jsp');
    } on PlatformException {
      print(PlatformException);
      print('PlatformException');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            initPlatformState();
          },
          child: Text('Do Payament')),
    );
  }
}
