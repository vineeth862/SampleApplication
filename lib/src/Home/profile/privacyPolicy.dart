import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class privacyPolicy extends StatefulWidget {
  const privacyPolicy({super.key});

  @override
  State<privacyPolicy> createState() => _privacyPolicyState();
}

class _privacyPolicyState extends State<privacyPolicy> {
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
    final content = await rootBundle.loadString('assets/PRIVACY_POLICY.txt');

    setState(() {
      documentContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Privacy Ploicy"),
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
  }
}
