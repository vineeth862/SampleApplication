import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/logout.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/Home/profile/edit_profile.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/addressbook.dart';

import '../../core/globalServices/db-operation/db_operations.dart';

// import '../../../utils/db-operation/db_operations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalService globalservice = GlobalService();
    Widget _CustomTextButton(
        IconData icon, String label_text, final pageDetails) {
      return InkWell(
        onTap: () {
          globalservice.navigate(context, pageDetails);
        },
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
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
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        width: 2.0,
                      ),
                      gradient: LinearGradient(colors: [
                        // Colors.grey.shade50,
                        // Colors.grey.shade100,
                        Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.5)
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
                        const Text(
                          'Guest', //Nedd to change as per user name
                          style: TextStyle(
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
                                      index: 3,
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
                        fontSize: 20,
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Preferences & Settings",
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
                    height: 232,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          width: 2.0,
                        ),
                        gradient: LinearGradient(
                            colors: [
                              // Colors.grey.shade50,
                              // Colors.grey.shade100,
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CustomTextButton(
                            Icons.home, "My Address Book", AdressBook()),
                        const Divider(
                          color: Colors.black,
                          thickness: 0.2,
                          height: 1,
                        ),
                        _CustomTextButton(Icons.settings_suggest_sharp,
                            "Settings", LogoutScreen()),
                        const Divider(
                            color: Colors.black, thickness: 0.2, height: 1),
                        _CustomTextButton(Icons.help_sharp, "Help or Support",
                            EditProfileScreen()),
                        const Divider(
                            color: Colors.black, thickness: 0.2, height: 1),
                        _CustomTextButton(Icons.menu_book_sharp, "About Us",
                            EditProfileScreen()),
                      ],
                    ),
                  )),
              // const SizedBox(height: 20),
              // TextButton(
              //   onPressed: () {
              //     // Handle edit profile button press
              //     globalservice.navigate(context, const Welcomesignin());
              //   },
              //   child: const Text('Login Screen'),
              // ),
              // const SizedBox(height: 20),
              // TextButton(
              //   onPressed: () {
              //     // Handle edit profile button press
              //     // globalservice.navigate(context, const SlotBooking());
              //   },
              //   child: const Text('SlotBooking'),
              // ),
              TextButton(
                onPressed: () {
                  // Handle edit profile button press
                  globalservice.navigate(context, GitHubRepositoriesScreen());
                },
                child: const Text('uploadList'),
              ),
              TextButton(
                onPressed: () async {
                  // Handle edit profile button press
                  final res =
                      await EasyUpiPaymentPlatform.instance.startPayment(
                    EasyUpiPaymentModel(
                      payeeVpa: 'Q720679555@ybl',
                      payeeName: 'Archana S',
                      amount: 1.0,
                      description: 'Testing payment',
                    ),
                  );

                  print(res);
                },
                child: const Text('Payment2'),
              ),
              // const SizedBox(height: 20),
              // TextButton(
              //   onPressed: () {
              //     // Handle edit profile button press
              //     globalservice.navigate(context, OrderTrackingScreen());
              //   },
              //   child: const Text('Order Tracking'),
              // ),
              // TextButton(
              //   onPressed: () {
              //     // Handle edit profile button press
              //     globalservice.navigate(context, FilterCategoryListPage());
              //   },
              //   child: const Text('Order Summary'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
