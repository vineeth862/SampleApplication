import 'package:flutter/material.dart';

class CardDetailPage extends StatefulWidget {
  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Card Detail"),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: const Column(children: [
            Center(child: Text("CardDetailPage")),
          ]),
        ),
      ),
    );
  }
}
