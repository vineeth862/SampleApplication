import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/profile/profile_home.dart';
import 'package:sample_application/src/screens/Home/explore/explore.dart';
import 'package:sample_application/src/screens/Home/home_service.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/screens/Home/order_tracker/orderTracker_home.dart';
import 'package:sample_application/src/screens/userAdress/initial_adress.dart';

import '../../utils/Provider/selected_test_provider.dart';
import '../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../utils/helper_widgets/slot-booking-card.dart';
import 'order_tracker/step1/step1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool shouldCallInit = true;
  HomeService homeService = HomeService();
  GlobalService globalservice = GlobalService();
  var Controller = Get.put(UserCurrentLocation());
  final myController = Get.find<UserCurrentLocation>();
  RxString Adress = "Fetching adress...".obs;

  String postalCode = "";
  String Locality = "";
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    Explore(),
    OrderTrackerHome()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onChangeOfPostalCode(String postalCode) {
    if (mounted) {
      setState(() {
        Adress = Adress;
      });
    }
  }

  // void loaddata() async {
  //   Position pos = await UserCurrentLocation.instance.determinePosition();
  //   List<Placemark> add = await UserCurrentLocation.instance.GetFullAdress(pos);
  //   Placemark place = add[0];
  //   postalCode = place.postalCode.toString();
  //   Locality = place.locality.toString();
  //   Adress = postalCode + ', ' + Locality;
  //   _onChangeOfPostalCode(Adress);
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   loaddata();
  // }

  bool expandDetails = false;

  @override
  Widget build(BuildContext context) {
    //final appState = context.read<AppState>();
    //final appStates = Provider.of<AppState>(context);

    final selectedTest = Provider.of<SelectedTestState>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: TextButton.icon(
      //     icon: Icon(Icons.location_on),
      //     label: Text(appStates
      //         .globalString), // label: Obx(() => Text(myController.globalString.value)),

      //     // label: Text(
      //     //   "${myController.globalString.value}",
      //     //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
      //     //         color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      //     //         fontWeight: FontWeight.bold,
      //     //       ),
      //     // ),
      //     onPressed: () {
      //       globalservice.navigate(context, InitialAdress());
      //     },
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Icon(
      //         Icons.rocket,
      //         color: Theme.of(context).colorScheme.primary,
      //       ),
      //     )
      //   ],
      //   foregroundColor: Theme.of(context).colorScheme.background,
      //   backgroundColor: Theme.of(context).colorScheme.background,
      // ),
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          Positioned(
            bottom: 100,
            right: 0,
            left: 0,
            child: SwipeableContainer(
                key: UniqueKey(),
                removeTest: (tesCode) {
                  selectedTest.removeTest(tesCode);
                  if (selectedTest.getSelectedTest.isEmpty) {
                    selectedTest.setDetailExpanded(false);
                  }
                }),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                child: selectedTest.getSelectedTest.isNotEmpty
                    ? SlotBookingCard(
                        title:
                            "${selectedTest.getSelectedTest.length} item Selected",
                        content: "view details",
                        buttonClicked: () {
                          globalservice.navigate(context, StepOneToBookTest());
                        },
                        hyperLink: true,
                        expandDetail: () {
                          setState(() {
                            expandDetails = true;
                          });
                        },
                      )
                    : Card()),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.moped_outlined),
            label: 'Order Tracker',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    ));
  }
}
