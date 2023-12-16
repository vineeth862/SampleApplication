import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/models/user/address.dart';
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
      },
    );
  }
}
