import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/profile/adress_book.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/screens/Home/profile/profile_home.dart';
import 'package:sample_application/src/screens/userAdress/add_address.dart';
import 'package:sample_application/src/screens/userAdress/address_operation.dart';

class AdressBook extends StatefulWidget {
  const AdressBook({super.key});

  @override
  State<AdressBook> createState() => _AdressBookState();
}

class _AdressBookState extends State<AdressBook> {
  GlobalService globalservice = GlobalService();
  var Controller = Get.put((UserRepository()));
  HomePageState homePageInstance = HomePageState();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.keyboard_double_arrow_down_rounded),
                      onTap: () {
                        //Navigator.pop(context);
                        globalservice.navigate(
                            context,
                            HomePage(
                              index: 0,
                            ));
                      },
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "Address Book",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);

                        globalservice.navigate(
                            context,
                            HomePage(
                              index: 0,
                            ));
                        //homePageInstance.returnedFromOtherScreen(0);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              addressOperation(
                routeDetails: AdressBook(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
