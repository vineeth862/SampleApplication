import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sample_application/src/Home/home.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    "./assets/images/MedCapH.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // const Padding(
                //   padding: EdgeInsets.all(18.0),
                //   child: Text("Sell Food Online",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: Colors.black54,
                //         fontSize: 40,
                //         fontFamily: "Signatra",
                //         letterSpacing: 3,
                //       )),
                // )
              ],
            ),
          )),
    );
  }
}
