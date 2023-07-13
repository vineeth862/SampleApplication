import 'package:flutter/material.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/profile/profile_home.dart';
import 'package:sample_application/src/screens/Home/explore/explore.dart';
import 'package:sample_application/src/screens/Home/home_service.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/screens/userAdress/initial_adress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeService homeService = HomeService();
  GlobalService globalservice = GlobalService();
  var Controller = Get.put(UserCurrentLocation());
  String Adress = "Fetching adress...";
  String postalCode = "";
  String Locality = "";
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    Explore(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onChangeOfPostalCode(String postalCode) {
    if (mounted) {
      setState(() {
        postalCode = postalCode;
      });
    }
  }

  void loaddata() async {
    Position pos = await UserCurrentLocation.instance.determinePosition();
    List<Placemark> add = await UserCurrentLocation.instance.GetFullAdress(pos);
    Placemark place = add[0];
    postalCode = place.postalCode.toString();
    Locality = place.locality.toString();
    Adress = postalCode + ', ' + Locality;
    _onChangeOfPostalCode(postalCode);
  }

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: TextButton.icon(
          icon: Icon(Icons.location_on),
          label: Text(
            Adress,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
          ),
          onPressed: () {
            globalservice.navigate(context, InitialAdress());
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.rocket,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
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
