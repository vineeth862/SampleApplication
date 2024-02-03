import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/Home/profile/edit_profile.dart';
import 'package:sample_application/src/Home/profile/policies.dart';
import 'package:sample_application/src/Home/profile/support.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/logout.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/core/globalServices/checkOnlineConnectivity.dart';
import 'package:sample_application/src/core/globalServices/authentication/onboarding/onboarding.dart';
import 'package:sample_application/src/core/globalServices/authentication/user_repository.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/addressbook.dart';

import '../../core/globalServices/authentication/auth_validation/authentication_repository.dart';
import '../models/user/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalService globalservice = GlobalService();
  var Controller = Get.put((UserRepository()));
  String? userName = "Guest";

  updateUserName() async {
    User sampleDatatemp = await UserRepository.instance.getUserData();

    setState(() {
      if (sampleDatatemp.userName != null) {
        userName = sampleDatatemp.userName;
      }
    });
  }

  void showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform logout logic here
                  // For demonstration purposes, we just print a message

                  AuthenticationRepository.instance.logout();
                  globalservice.navigate(context, Welcomesignin());
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  // Close the bottom sheet
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    updateUserName();
  }

  Widget _CustomTextButton(String path, String label_text, final pageDetails) {
    return InkWell(
      onTap: () {
        globalservice.navigate(context, pageDetails);
      },
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Image.asset(
                  path,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(label_text),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      "|",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Profile",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Theme.of(context)
                      //       .colorScheme
                      //       .primary
                      //       .withOpacity(0.2),
                      //   width: 2.0,
                      // ),

                      gradient: LinearGradient(colors: [
                        // Colors.grey.shade50,
                        // Colors.grey.shade100,
                        Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("./assets/images/user.png"),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          userName.toString(), //Nedd to change as per user name
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return EditProfileScreen();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.fastOutSlowIn;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                      // var fadeAnimation =
                                      //     Tween<double>(begin: 0.0, end: 1.0)
                                      //         .animate(animation);

                                      // return FadeTransition(
                                      //   opacity: fadeAnimation,
                                      //   child: SlideTransition(
                                      //     position: offsetAnimation,
                                      //     child: child,
                                      //   ),
                                      // );
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              ), //icon data for elevated button
                              label: const Text("Edit Profile"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set the border radius value
                                ),
                                primary: Theme.of(context).colorScheme.primary,
                                //   padding:
                                //       EdgeInsets.symmetric(horizontal: 100.0),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                globalservice.navigate(
                                    context,
                                    HomePage(
                                      index: 2,
                                    ));
                              },
                              icon: const Icon(
                                Icons.badge,
                                size: 20,
                              ), //icon data for elevated button
                              label: const Text(
                                "Bookings",
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set the border radius value
                                ),
                                primary: Theme.of(context).colorScheme.primary,
                                //   padding:
                                //       EdgeInsets.symmetric(horizontal: 100.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                child: Row(
                  children: [
                    Text(
                      "|",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Preferences",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CustomTextButton('assets/images/home.png',
                          "Saved Address", const AdressBook()),
                      // const Divider(
                      //   color: Colors.black,
                      //   thickness: 0.2,
                      //   height: 1,
                      // ),
                      // _CustomTextButton('assets/images/setting.jpeg',
                      //     "Settings", LogoutScreen()),
                      const Divider(
                          color: Colors.black, thickness: 0.2, height: 1),
                      _CustomTextButton('assets/images/support.jpeg',
                          "Help or Support", const Support()),
                      const Divider(
                          color: Colors.black, thickness: 0.2, height: 1),
                      _CustomTextButton('assets/images/about.jpeg', "About Us",
                          const policices()),
                      const Divider(
                          color: Colors.black, thickness: 0.2, height: 1),
                      // _CustomTextButton('assets/images/lagout.png', "Log Out",
                      //     const LogoutScreen()),
                      InkWell(
                        onTap: () {
                          showLogoutConfirmation(context);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    'assets/images/lagout.png',
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text("Log Out"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                          color: Colors.black, thickness: 0.2, height: 1),
                    ],
                  )),
              // TextButton(
              //     onPressed: () {
              //       globalservice.navigate(context, onBoardingScreen());
              //     },
              //     child: Text("Onboard")),
            ],
          ),
        ),
      ),
    );
  }
}
