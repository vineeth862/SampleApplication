import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/home.dart';

import '../screens/Home/models/lab/lab.dart';
import '../utils/Provider/address_provider.dart';
import '../utils/Provider/search_provider.dart';

class UserCurrentLocation extends GetxController {
  static UserCurrentLocation get instance => Get.find();
  RxString addressToBeConsidered = 'Fetching adress'.obs;
  RxString location = 'Fetching adress'.obs;
  RxString pinCode = 'Fetching adress'.obs;
  RxString area = '...'.obs;
  final appState = AppState();
  Position? latAndLong;
  //final appStates = Provider.of<AppState>(context);
  String? postalCode;
  String? locality;
  String adress = "Fetching adress";
  List<Lab> availabelLabs = [];

  RxBool pinCodeExists = true.obs;
  //RxString globalString = 'Initial Value'.obs;
  bool hasInitialValueChanged = false;

  GlobalService globalService = GlobalService();
  void updateGlobalString(String newValue) {
    if (!hasInitialValueChanged) {
      hasInitialValueChanged = true;
      appState.updateGlobalStringValue(newValue);
      // Perform your one-time operation here
      //print('Performing one-time operation');
      addressToBeConsidered.value = newValue;
      Future.delayed(Duration(seconds: 0), () {
        //loadingProvider.startLoading();
        //Get.offAll(() => HomePage());

        //loadingProvider.stopLoading();
      });

      //validatePincode(pinCode);
    } else {
      appState.updateGlobalStringValue(newValue);
      // Perform your one-time operation here

      addressToBeConsidered.value = newValue;
      pinCode.value = newValue;
      location.value = newValue;
      area.value = newValue;
      filterLabOnPinCode();
      validatePincode(pinCode);
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  GetFullAdress(Position pos) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    //print(placemark);
    return placemark;
  }

  @override
  void onReady() {
    Future.delayed(Duration(seconds: 0), () {
      //loadingProvider.startLoading();

      loaddata();

      //loadingProvider.stopLoading();
    });
  }

  loaddata() async {
    Position pos = await UserCurrentLocation.instance.determinePosition();
    //print(pos.latitude);
    latAndLong = pos;
    List<Placemark> add = await UserCurrentLocation.instance.GetFullAdress(pos);
    //print(add);
    Placemark place = add[0];
    postalCode = place.postalCode.toString();
    locality = place.locality.toString();
    adress = postalCode! + ', ' + locality!;
    location = RxString(place.subLocality.toString());
    area = RxString(add[4].name.toString());
    pinCode = RxString(postalCode.toString());
    SearchListState().filterLabOnPinCode();
    validatePincode(pinCode);
    //print(fulladd.Name);
    updateGlobalString(adress);
    //print(globalString.value);
  }

  filterLabOnPinCode() async {
    var labList = await FirebaseFirestore.instance.collection('lab').get();
    availabelLabs = labList.docs.map((doc) {
      return Lab.fromJson(doc.data());
    }).where((element) {
      return element.branchDetails
          .where((element) =>
              element.availablePincodeDetails.contains(pinCode.toString()))
          .isNotEmpty;
    }).toList();
    print(availabelLabs);
  }

  validatePincode(pinCode) async {
    var pinCodeList = FirebaseFirestore.instance.collection('pincode');
    final isPincode = await pinCodeList.doc(pinCode.toString()).get();

    pinCodeExists.value = isPincode.exists;
    //print(pinCodeExists);
  }
}
