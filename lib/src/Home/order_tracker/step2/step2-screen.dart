import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/models/user/address.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/address_operation_step2.dart';
import 'package:sample_application/src/core/helper_widgets/snackbar.dart';

import '../../../core/Provider/selected_order_provider.dart';
import '../../../core/globalServices/global_service.dart';

class StepTwoScreen extends StatefulWidget {
  final screen = _StepTwoScreenState();
  Address? selectedAdress;
  Function(Address address) addressChanged;

  StepTwoScreen({required this.addressChanged});

  @override
  _StepTwoScreenState createState() => screen;
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  SelectedOrderState? selectedOrder;

  GlobalService globalservice = GlobalService();

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    bool isButtonEnabled = false;
    bool isItemsNotPresent = false;

    return addressOperationStepTwo(
      routeDetails: StepTwoScreen(addressChanged: (adress) {}),
      addressSelected: (address) async {
        Order order = selectedOrder!.getOrder;
        if (await UserCurrentLocation.instance
            .validateUserSelectedPincode(order.tests![0].labCode, address)) {
          setState(() {
            widget.selectedAdress = address;
            widget.addressChanged(address);
            Order order = selectedOrder!.getOrder;
            order.address = widget.selectedAdress;
            // int totalAmount = 0;
            // order.tests?.forEach((element) {
            //   totalAmount += int.parse(element.price);
            // });
            // order.totalPrice = totalAmount;
            selectedOrder!.setOrder = order;
          });
        } else {
          // ignore: use_build_context_synchronously
          CustomSnackbar.showSnackbar(
              'Address is not servicable for the selected lab');
          // Get.showSnackbar(
          //   GetSnackBar(
          //     backgroundColor: Color.fromARGB(255, 203, 57, 24),

          //     icon: Icon(
          //       Icons.warning_amber_rounded,
          //       color: Theme.of(context).colorScheme.secondary,
          //     ),
          //     forwardAnimationCurve: Curves.decelerate,
          //     //margin: EdgeInsets.all(10),
          //     message: 'Address is not servicable for the selected lab',
          //     maxWidth: 400, // Set the desired width
          //     duration: Duration(seconds: 3),
          //     snackPosition: SnackPosition.BOTTOM, // Optional: Specify position
          //   ),
          // );
          // Get.snackbar("", "Address is not servicable for the selected lab,",
          //     colorText: Colors.white,
          //     icon: Icon(
          //       Icons.warning_amber_rounded,
          //     ),
          //     backgroundColor: Color.fromARGB(255, 9, 78, 9),
          //     dismissDirection: DismissDirection.horizontal,
          //     //forwardAnimationCurve: ElasticInOutCurve(),
          //     duration: Duration(seconds: 2),
          //     snackPosition: SnackPosition.BOTTOM
          //     //colorText: Theme.of(context).colorScheme.primary,
          //     );
        }
      },
    );
  }
}
