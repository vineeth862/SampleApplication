import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../utils/Provider/address_provider.dart';

class UserCurrentLocation extends GetxController {
  static UserCurrentLocation get instance => Get.find();
  RxString globalString = 'Fetching adress...'.obs;
  final appState = AppState();
  Position? latAndLong;
  //final appStates = Provider.of<AppState>(context);
  String? postalCode;
  String? locality;
  String adress = "Fetching adress...";
  //RxString globalString = 'Initial Value'.obs;
  bool hasInitialValueChanged = false;
  void updateGlobalString(String newValue) {
    if (!hasInitialValueChanged) {
      hasInitialValueChanged = true;
      appState.updateGlobalStringValue(newValue);
      // Perform your one-time operation here
      print('Performing one-time operation');
      globalString.value = newValue;
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
    loaddata();
  }

  loaddata() async {
    Position pos = await UserCurrentLocation.instance.determinePosition();
    //print(pos.latitude);
    latAndLong = pos;
    List<Placemark> add = await UserCurrentLocation.instance.GetFullAdress(pos);
    print(add);
    Placemark place = add[0];
    postalCode = place.postalCode.toString();
    locality = place.locality.toString();
    adress = postalCode! + ', ' + locality!;
    //print(fulladd.Name);
    updateGlobalString(adress);
    print(globalString.value);
  }
}
