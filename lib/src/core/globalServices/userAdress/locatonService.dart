import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import '../../../Home/models/lab/lab.dart';
import '../../Provider/address_provider.dart';
import '../../Provider/search_provider.dart';

class UserCurrentLocation extends GetxController {
  static UserCurrentLocation get instance => Get.find();
  RxBool locationAccessRequest = false.obs;
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

  var locationPermission = LocationPermission.whileInUse;
  GlobalService globalService = GlobalService();
  void updateGlobalString(String newValue) {
    if (!hasInitialValueChanged) {
      hasInitialValueChanged = true;
      appState.updateGlobalStringValue(newValue);
      // Perform your one-time operation here
      //print('Performing one-time operation');
      addressToBeConsidered.value = newValue;

      //validateAvailablePincode(pinCode);
    } else {
      appState.updateGlobalStringValue(newValue);
      // Perform your one-time operation here

      addressToBeConsidered.value = newValue;
      pinCode.value = newValue;
      location.value = newValue;
      area.value = newValue;
      filterLabOnPinCode();
      validateAvailablePincode(pinCode);
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    //LocationPermission permission;

    // Test if location services are enabled.

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      //return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      await requestLocationPermission();
      //locationPermission = await Geolocator.requestPermission();
      // if (locationPermission == LocationPermission.denied) {
      //   showPermissionDeniedDialog();
      //   //locationPermission = await Geolocator.requestPermission();
      //   // Permissions are denied, next time you could try
      //   // requesting permissions again (this is also where
      //   // Android's shouldShowRequestPermissionRationale
      //   // returned true. According to Android guidelines
      //   // your App should show an explanatory UI now.
      //   //locationAccessRequest.value = false;
      //   //return Future.error('Location permissions are denied');
      // }
    } else if (locationPermission == LocationPermission.deniedForever) {
      showPermissionDeniedDialog();
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.best);
  }

  GetFullAdress(Position pos) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    //print(placemark);
    return placemark;
  }

  void showPermissionDeniedDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Location Permission'),
        content:
            Text('Please enable location services in your device settings.'),
        actions: [
          TextButton(
            onPressed: () async {
              requestLocationPermission();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    try {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();

        //showPermissionDeniedDialog();
      } else if (locationPermission == LocationPermission.denied) {
        showPermissionDeniedDialog();
      } else {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      }
    } catch (e) {
      print("Error requesting location permission: $e");
    }
  }

  @override
  void onReady() {
    Future.delayed(Duration(seconds: 0), () {
      //globalservice.showLoader();

      loaddata();

      //globalservice.hideLoader();
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
    for (Placemark place in add) {
      if (place.name!.length > area.toString().length) {
        area = RxString(place.name.toString());
      }
    }

    pinCode = RxString(postalCode.toString());
    SearchListState().filterLabOnPinCode();
    validateAvailablePincode(pinCode);
    //print(fulladd.Name);
    updateGlobalString(adress);
    //print(globalString.value);
  }

  filterLabOnPinCode() async {
    var labList = await FirebaseFirestore.instance.collection('prod-lab').get();
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

  validateAvailablePincode(pinCode) async {
    var pinCodeList = FirebaseFirestore.instance.collection('pincode');
    final isPincode = await pinCodeList.doc(pinCode.toString()).get();

    pinCodeExists.value = isPincode.exists;
    //print(pinCodeExists);
  }

  validateUserEnteredAddressPincode(pincode) async {
    var pinCodeList = FirebaseFirestore.instance.collection('pincode');
    final isPincode = await pinCodeList.doc(pincode.toString()).get();

    return isPincode.exists;
  }

  validateUserSelectedPincode(String labCode, selectedAddress) async {
    //String labCode = orderObj.labCode;

    String selectedPincode = selectedAddress.pincode;

    var labList = await FirebaseFirestore.instance
        .collection('prod-lab')
        .where("labCode", isEqualTo: labCode)
        .get();
    var availablePincodeList = [];
    var availablePincodeListNested = labList.docs.map((doc) {
      return doc.data()['branchDetails'].map((element) {
        return element['availablePincodeDetails'];
      });
    }).toList();
    for (var sublist in availablePincodeListNested) {
      availablePincodeList.addAll(sublist);
    }

    availablePincodeList =
        availablePincodeList.expand((element) => element).toList();
    //var availablePincodeList = labList.docs.map((lab) => {lab.data()}).toList();
    return availablePincodeList.contains(selectedPincode);
  }
}
