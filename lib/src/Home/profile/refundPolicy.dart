import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefundPolicy extends StatefulWidget {
  const RefundPolicy({super.key});

  @override
  State<RefundPolicy> createState() => _RefundPolicyState();
}

class _RefundPolicyState extends State<RefundPolicy> {
  String? documentContent;

  @override
  void initState() {
    super.initState();
    // Load text document content on widget initialization
    loadDocumentContent();
  }

  Future<void> loadDocumentContent() async {
    // Replace 'assets/sample.txt' with the path to your text document
    //final file = File('assets/PRIVACY_POLICY.txt');
    final content = await rootBundle
        .loadString('assets/Refund_and_Cancellation_Policy.txt');

    setState(() {
      documentContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Refund Ploicy"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  documentContent ??
                      'Loading...', // Display 'Loading...' while content is being loaded
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          )),
    );
    ;
  }
}
