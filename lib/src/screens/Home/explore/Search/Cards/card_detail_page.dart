import 'package:flutter/material.dart';

class CardDetailPage extends StatefulWidget {
  const CardDetailPage({super.key});

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(176, 113, 187, 1)),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text(
            "Test Details",
            style: TextStyle(color: Color.fromRGBO(176, 113, 187, 1)),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes the shadow position
                        ),
                      ],
                    ),
                    child: const Card(
                      child: Center(
                        child: Text(
                          'Hello, Flutter!',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
