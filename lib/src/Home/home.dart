import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/doctor_consultation.dart/home-care-services.dart';
import 'package:sample_application/src/Home/explore/explore.dart';
import 'package:sample_application/src/Home/home_service.dart';
import 'package:sample_application/src/Home/order_tracker/order-summary/orderSumaryScreen.dart';
import 'package:sample_application/src/Home/order_tracker/orderTracker_home.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import '../core/Provider/selected_order_provider.dart';
import '../core/Provider/selected_test_provider.dart';
import '../core/globalServices/execution-stack/execution_stack_operation.dart';
import '../core/helper_widgets/slot-booking-card.dart';
import 'models/order/order.dart';
import 'order_tracker/step1/step1.dart';
import 'profile/profile_home.dart';

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
  ExecutionStackOperation executionStackOperation = ExecutionStackOperation();
  String postalCode = "";
  String Locality = "";
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    //Explore(),
    const exploreExp(),

    const HomeCareServices(),
    OrderTrackerHome(
      from: 'home',
    ),
    ProfileScreen(),
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
    num slotBookingCardHeight = 120;
    if (widget.index != null) {
      setState(() {
        selectedIndex = int.parse(widget.index.toString());
        widget.index = null;
      });
    }
    final selectedTest = Provider.of<SelectedTestState>(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return await executionStackOperation.isRemoveWidget("home", context);
        },
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

          // Obx(
          //   () => (myController.pinCodeExists.value)
          //       ?
          body: Stack(
            children: [
              _widgetOptions.elementAt(selectedIndex),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                    child: (selectedTest.getSelectedTest.isNotEmpty ||
                            selectedTest.getSelectedPackage.isNotEmpty)
                        ? SlotBookingCard(
                            selectedCount: selectedTest.getSelectedTest.length +
                                selectedTest.getSelectedPackage.length,
                            title: " Test/Package Selected",
                            content: "view details",
                            subContent: "",
                            contentColor: false,
                            height: slotBookingCardHeight,
                            buttonClicked: () {
                              Order order = selectedOrder.getOrder;

                              Widget widget = order.statusCode == 1
                                  ? OrderSummaryScreen()
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
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.airline_seat_flat),
              //   label: 'Radiology',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital_sharp),
                label: 'Home Care Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.moped_outlined),
                label: 'Track Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: 'Profile',
              )
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            unselectedItemColor: Theme.of(context).colorScheme.onBackground,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
