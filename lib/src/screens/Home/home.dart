import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/doctor_consultation.dart/doctorConsultation.dart';
import 'package:sample_application/src/screens/Home/explore/explore_exp.dart';
import 'package:sample_application/src/screens/Home/order_tracker/payment/paymentScreen.dart';
import 'package:sample_application/src/screens/Home/home_service.dart';
import 'package:sample_application/src/screens/Home/order_tracker/orderTracker_home.dart';
import 'package:sample_application/src/screens/Home/radiology/radiology.dart';
import 'package:sample_application/src/screens/userAdress/initial_adress.dart';
import 'package:sample_application/src/utils/Provider/loading_provider.dart';
import '../../utils/Provider/selected_order_provider.dart';
import '../../utils/Provider/selected_test_provider.dart';
import '../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../utils/helper_widgets/slot-booking-card.dart';
import 'models/order/order.dart';
import 'order_tracker/step1/step1.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.index});
  int? index;
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool shouldCallInit = true;
  HomeService homeService = HomeService();
  GlobalService globalservice = GlobalService();
  var Controller = Get.put(UserCurrentLocation());
  final myController = Get.find<UserCurrentLocation>();
  RxString Adress = "Fetching adress...".obs;

  String postalCode = "";
  String Locality = "";
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    //ProfileScreen(),
    //Explore(),
    const exploreExp(),
    const Radiology(),
    const DoctorConsultation(),
    OrderTrackerHome(
      from: 'home',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void returnedFromOtherScreen(int index) {
    setState(() {
      selectedIndex = index;
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
  late LoadingProvider loadingProvider;
  @override
  void initState() {
    super.initState();
  }

  bool expandDetails = false;

  @override
  Widget build(BuildContext context) {
    //final appState = context.read<AppState>();
    //final appStates = Provider.of<AppState>(context);
    final selectedOrder = Provider.of<SelectedOrderState>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    if (widget.index != null) {
      setState(() {
        selectedIndex = int.parse(widget.index.toString());
        widget.index = null;
      });
    }
    final selectedTest = Provider.of<SelectedTestState>(context);
    print(myController.availabelLabs);

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
        // ignore: unrelated_type_equality_checks

        body: Obx(
          () => (myController.pinCodeExists.value)
              ? Stack(
                  children: [
                    _widgetOptions.elementAt(selectedIndex),
                    Positioned(
                      bottom: 100,
                      right: 0,
                      left: 0,
                      child: SwipeableContainer(
                          key: UniqueKey(),
                          removeTest: (tesCode) {
                            selectedTest.removeTest(tesCode);
                            if (selectedTest.getSelectedTest.isEmpty &&
                                selectedTest.getSelectedPackage.isEmpty) {
                              selectedTest.setDetailExpanded(false);
                            }
                          },
                          removePackage: (pacCode) {
                            selectedTest.removePackage(pacCode);
                            if (selectedTest.getSelectedTest.isEmpty &&
                                selectedTest.getSelectedPackage.isEmpty) {
                              selectedTest.setDetailExpanded(false);
                            }
                          }),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                          child: (selectedTest.getSelectedTest.isNotEmpty ||
                                  selectedTest.getSelectedPackage.isNotEmpty)
                              ? SlotBookingCard(
                                  selectedCount: selectedTest
                                          .getSelectedTest.length +
                                      selectedTest.getSelectedPackage.length,
                                  title: " Test/Package Selected",
                                  content: "view details",
                                  subContent: "",
                                  contentColor: false,
                                  buttonClicked: () {
                                    Order order = selectedOrder.getOrder;

                                    Widget widget = order.statusCode == 1
                                        ? PaymentScreeen()
                                        : StepOneToBookTest();

                                    globalservice.navigate(context, widget);
                                  },
                                  hyperLink: true,
                                  expandDetail: () {
                                    setState(() {
                                      expandDetails = true;
                                    });
                                  },
                                )
                              : const Card()),
                    ),
                  ],
                )
              : Container(
                  //color: Theme.of(context).colorScheme.primary,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage("./assets/images/MedCapH.jpg"),
                      //     fit: BoxFit.cover
                      //     // Set your desired image fit
                      //     ),
                      gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  ])),
                  //color: Theme.of(context).colorScheme.primary,

                  child: AlertDialog(
                    //icon: Icon(Icons.time_to_leave),
                    alignment: const AlignmentDirectional(1, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text("Oh,no!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary)),
                    content: Obx(() => Text(
                          "Service not available in " +
                              myController.addressToBeConsidered.value,
                          style: Theme.of(context).textTheme.titleMedium!,
                        )),
                    actions: [
                      // Define buttons for the AlertDialog
                      ElevatedButton(
                        style: ButtonStyle(
                            // minimumSize: MaterialStateProperty.all(
                            //     const Size(80, 25)), // Set the desired size
                            ),
                        child: const Text("Change Location"),
                        onPressed: () {
                          globalservice.navigate(context,
                              const InitialAdress()); // Close the AlertDialog
                        },
                      ),
                    ],
                    actionsAlignment: MainAxisAlignment.end,
                  ),
                ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airline_seat_flat),
              label: 'Radiology',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital_sharp),
              label: 'Dr.Consultation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.moped_outlined),
              label: 'Track Order',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          unselectedItemColor: Theme.of(context).colorScheme.onBackground,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
