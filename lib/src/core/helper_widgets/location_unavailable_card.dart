import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/initial_adress.dart';

class LocationNotAvailable extends StatelessWidget {
  LocationNotAvailable({super.key});

  final myController = Get.find<UserCurrentLocation>();
  GlobalService globalservice = GlobalService();

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Theme.of(context).colorScheme.primary,
      decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("./assets/images/MedCapH.jpg"),
          //     fit: BoxFit.cover
          //     // Set your desired image fit
          //     ),
          //     gradient: LinearGradient(colors: [
          //   // Theme.of(context).colorScheme.secondaryContainer,
          //   // Theme.of(context).colorScheme.secondaryContainer
          //   Color.fromARGB(255, 255, 255, 255),
          //   Color.fromARGB(255, 255, 255, 255),
          // ])
          ),
      //color: Theme.of(context).colorScheme.primary,

      child: AlertDialog(
        backgroundColor: const Color.fromARGB(255, 240, 227, 226),
        //icon: Icon(Icons.time_to_leave),
        alignment: const AlignmentDirectional(0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        title: Text("😞 " + "Oh,no!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        content: Obx(() => Text(
              "Service not available in " +
                  myController.addressToBeConsidered.value,
              style: Theme.of(context).textTheme.headlineMedium!,
            )),
        actions: [
          // Define buttons for the AlertDialog
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius value
              ),
              primary: Theme.of(context).colorScheme.tertiary,
              //padding: const EdgeInsets.symmetric(horizontal: 100.0),
            ),
            child: const Text("Change Location"),
            onPressed: () {
              globalservice.navigate(
                  context, const InitialAdress()); // Close the AlertDialog
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }
}

class LocationAccesDeclined extends StatelessWidget {
  LocationAccesDeclined({super.key});
  LocationPermission? permission;

  final myController = Get.find<UserCurrentLocation>();
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    return Container(
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
        alignment: const AlignmentDirectional(0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("Oh,no!",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        content: Text(
          "Please enable location to proceed ",
          style: Theme.of(context).textTheme.titleMedium!,
        ),
        actions: [
          // Define buttons for the AlertDialog
          ElevatedButton(
            style: const ButtonStyle(
                // minimumSize: MaterialStateProperty.all(
                //     const Size(80, 25)), // Set the desired size
                ),
            child: const Text("Enable Location"),
            onPressed: () async {
              // var permission = await Geolocator.checkPermission();
              // if (permission == LocationPermission.denied) {
              //   permission = await Geolocator.requestPermission();
              //   if (permission == LocationPermission.denied) {
              //     UserCurrentLocation.instance.locationAccessRequest.value =
              //         false;
              //   } else if (permission == LocationPermission.deniedForever) {
              //     UserCurrentLocation.instance.locationAccessRequest.value =
              //         false;
              //   } else {
              //     UserCurrentLocation.instance.locationAccessRequest.value =
              //         true;
              //   }

              //   globalservice.navigate(context, HomePage());
              // }
              Navigator.pop(context);

              //UserCurrentLocation.instance.loaddata(); // Close the AlertDialog
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
