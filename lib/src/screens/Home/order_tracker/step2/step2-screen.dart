import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/userAdress/address_operation_step2.dart';
import '../../../../global_service/global_service.dart';
import '../../../../utils/Provider/selected_order_provider.dart';

class StepTwoScreen extends StatefulWidget {
  final screen = _StepTwoScreenState();
  String selectedAdress = "";
  Function(String address) addressChanged;

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
      addressSelected: (address) {
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
