import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/authentication_repository.dart';

class ConnectivityController extends GetxController {
  RxBool isOnline = RxBool(false);

  Future<void> checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    isOnline(result != ConnectivityResult.none);
  }
}

class ConnectivityChecker extends StatefulWidget {
  @override
  _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  final ConnectivityController _controller = Get.put(ConnectivityController());

  @override
  void initState() {
    super.initState();
    _checkConnectivityOnInit();
  }

  Future<void> _checkConnectivityOnInit() async {
    await _controller.checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () {
            if (_controller.isOnline.value) {
              // Device is online, redirect to the homepage
              Future.delayed(Duration.zero, () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           AuthenticationRepository.instance.screenRedirect()),
                // );
                AuthenticationRepository.instance.screenRedirect();
              });
              return CircularProgressIndicator(); // Optional loading indicator while redirecting
            } else {
              // Device is offline, show a dialog
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "./assets/images/noWifi.png",
                    height: 150,
                  ),
                  Text('You are Offline',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You are not connected to the internet. Please connect to the internet and try again",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.checkConnectivity();
                    },
                    child: Text(
                      'Retry',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        backgroundColor: Color.fromARGB(255, 204, 38, 38),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
