import 'package:flutter/material.dart';
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("Oh,no!",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
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
