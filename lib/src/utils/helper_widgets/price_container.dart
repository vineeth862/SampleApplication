import 'package:flutter/material.dart';

import '../../global_service/global_service.dart';

class Price extends StatelessWidget {
  String? finalAmount;
  bool isTotalPricePresent;
  String? discount;

  String? discountedAmount;

  Price(
      {this.finalAmount,
      this.discount,
      required this.isTotalPricePresent,
      required this.discountedAmount});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    //double amount = double.parse(finalAmount!.toString());
    //int disc = int.parse(discount!);
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: [
              isTotalPricePresent!
                  ? Text(" Total Price : ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface))
                  : Container(),
              Text("₹$discountedAmount",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                width: 5,
              ),
              Text(finalAmount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color.fromARGB(255, 210, 55, 31),
                        decoration: TextDecoration.lineThrough,
                      )),
              const SizedBox(
                width: 5,
              ),
              discount!.isNotEmpty
                  ? Text(discount.toString() + "%",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.tertiary))
                  : Text(""),
            ],
          ),
        ),
      ],
    );
  }
}
