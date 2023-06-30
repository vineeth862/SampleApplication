import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/welcome_signin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalService globalservice = GlobalService();
    Widget _CustomTextButton(Icon icon, String label_text, final pageDetails) {
      return TextButton.icon(
          icon: icon,
          onPressed: () {
            //globalservice.navigate(context, pageDetails);
          },
          label: Text(
            label_text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
          ));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
          ),
        ),
        //   foregroundColor: Theme.of(context).colorScheme.onPrimary,
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        Colors.grey.shade50,
                        Colors.grey.shade100,
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
                                globalservice.navigate(
                                    context, EditProfileScreen());
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
                              onPressed: () {},
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
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
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
                              Colors.grey.shade50,
                              Colors.grey.shade100,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _CustomTextButton(const Icon(Icons.home),
                              "My Address Book", EditProfileScreen()),
                          const Divider(color: Colors.black, thickness: 0.2),
                          _CustomTextButton(
                              const Icon(Icons.settings_suggest_sharp),
                              "Settings",
                              EditProfileScreen()),
                          const Divider(color: Colors.black, thickness: 0.2),
                          _CustomTextButton(const Icon(Icons.help_sharp),
                              "Help or Support", EditProfileScreen()),
                          const Divider(color: Colors.black, thickness: 0.2),
                          _CustomTextButton(const Icon(Icons.menu_book_sharp),
                              "About Us", EditProfileScreen()),
                          const Divider(color: Colors.black, thickness: 0.2)
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Handle edit profile button press
                  globalservice.navigate(context, const Welcomesignin());
                },
                child: const Text('Login Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
