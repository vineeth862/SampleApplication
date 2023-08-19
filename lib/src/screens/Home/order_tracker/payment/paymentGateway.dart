import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController amountController = TextEditingController();

  Future<void> createOrderAndCapturePayment() async {
    final apiUrl =
        'http://your-server-address:your-port/create_order'; // Replace with your server address
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'amount': amountController.text}),
    );

    if (response.statusCode == 200) {
      final orderData = json.decode(response.body);
      final paymentId = orderData['id'];

      final captureUrl =
          'http://your-server-address:your-port/payment_capture'; // Replace with your server address
      final captureResponse = await http.post(
        Uri.parse(captureUrl),
        headers: {'Content-Type': 'application/json'},
        body: json
            .encode({'payment_id': paymentId, 'amount': amountController.text}),
      );

      if (captureResponse.statusCode == 200) {
        final captureData = json.decode(captureResponse.body);
        if (captureData['status'] == 'success') {
          // Payment captured successfully
          // You can perform any additional actions here
        } else {
          // Payment capture failed
        }
      } else {
        // Failed to capture payment
      }
    } else {
      // Failed to create order
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                createOrderAndCapturePayment();
              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:crypto/crypto.dart';
// import 'dart:convert';

// class _PaymentScreenState extends State<PaymentScreen> {
//   // ...

//   String generateSignature(Map<String, dynamic> payload) {
//     // Combine the payload values into a string
//     final dataString = "${payload['appId']}${payload['orderId']}${payload['orderAmount']}${payload['orderCurrency']}${payload['orderNote']}${payload['customerName']}${payload['customerPhone']}${payload['customerEmail']}YOUR_SECRET_KEY";

//     // Generate SHA-256 hash
//     final signatureBytes = utf8.encode(dataString);
//     final signature = sha256.convert(signatureBytes);
//     return signature.toString();
//   }

//   Future<void> initiatePayment() async {
//     // ...

//     final payload = {
//       'appId': API_KEY,
//       'orderId': orderController.text,
//       'orderAmount': double.parse(amountController.text).toStringAsFixed(2),
//       'orderCurrency': 'INR',
//       'orderNote': 'Sample order',
//       'customerName': 'John Doe',
//       'customerPhone': contactController.text,
//       'customerEmail': emailController.text,
//       'returnUrl': 'YOUR_RETURN_URL',
//       'notifyUrl': 'YOUR_NOTIFY_URL',
//       'paymentModes': '',
//     };

//     final signature = generateSignature(payload);

//     payload['signature'] = signature;

//     final response = await http.post(url, headers: headers, body: jsonEncode(payload));
//     // ...
//   }
  
//   // ...
// }




//Phone pe
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final TextEditingController orderController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   Future<void> initiatePayment() async {
//     final url = Uri.parse('http://YOUR_SERVER_IP:YOUR_SERVER_PORT/initiate_payment');
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body = {
//       'order_id': orderController.text,
//       'amount': double.parse(amountController.text).toStringAsFixed(2),
//     };

//     final response = await http.post(url, headers: headers, body: jsonEncode(body));
//     if (response.statusCode == 200) {
//       // Handle the response, you might want to navigate to a WebView or another screen
//       // to continue the payment process.
//       print('Payment initiated: ${response.body}');
//     } else {
//       // Handle error
//       print('Payment initiation failed: ${response.body}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Initiate Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: orderController,
//               decoration: InputDecoration(labelText: 'Order ID'),
//             ),
//             TextField(
//               controller: amountController,
//               decoration: InputDecoration(labelText: 'Amount'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: initiatePayment,
//               child: Text('Initiate Payment'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




