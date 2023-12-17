import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/models/user/address.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/address_operation_step2.dart';

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
          Get.snackbar(
              "Info", "Address is not servicable for the selected lab,",
              icon: Icon(
                Icons.warning_amber_rounded,
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: ElasticInOutCurve(),
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.TOP
              //colorText: Theme.of(context).colorScheme.primary,
              );
        }
      },
    );
  }
}
