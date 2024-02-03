import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Home/order_tracker/orderTracker_progress.dart';
import '../global_service.dart';

class ServiceScreen extends StatefulWidget {
  Order order;
  ServiceScreen({ required this.order});
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  GlobalService globalservice = GlobalService();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Service Screen'),
      // ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "./assets/images/payment-service-not-available.png",
                  height: 150,
                ),
                SizedBox(height: 30),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Payment Successful",style: TextStyle(color: Colors.green,fontSize: 25)),
                  Icon(IconData(0xf635, fontFamily: 'MaterialIcons'),size: 30,color: Colors.green,)]),

                // Spacer(),
                SizedBox(height: 100),
                Text(
                  'Thank you for choosing MedcapH.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Payments are currently not being Accepted !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.tertiary),
                  onPressed: () {
                    globalservice.navigate(context, OrderTrackingScreen(order: widget.order));
                  },
                  child: Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
