import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';

class orderTraExp extends StatefulWidget {
  const orderTraExp({super.key});

  @override
  State<orderTraExp> createState() => _orderTraExpState();
}

class _orderTraExpState extends State<orderTraExp> {
  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Order Placed",
        textStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      subtitle: StepperText("Your order has been placed"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    ),
    StepperData(
        title: StepperText("Preparing"),
        subtitle: StepperText("Your order is being prepared"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        title: StepperText("On the way"),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Delivered",
            textStyle: const TextStyle(color: Colors.grey)),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnotherStepper(
          stepperList: stepperData,
          stepperDirection: Axis.horizontal,
          iconWidth: 40,
          iconHeight: 40,
          activeBarColor: Colors.green,
          inActiveBarColor: Colors.grey,
          inverted: true,
          verticalGap: 30,
          activeIndex: 3,
          barThickness: 3,
        ),
      ),
    );
  }
}
