import 'package:flutter/material.dart';

import '../../global_service/global_service.dart';

class Price extends StatelessWidget {
  String? finalAmount;
  String? discount;

  Price({this.finalAmount, this.discount});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    int amount = int.parse(finalAmount!);
    int disc = int.parse(discount!);
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: [
              Text(" Total Price : ",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface)),
              Text("₹${amount}",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                width: 5,
              ),
              discount!.isNotEmpty
                  ? Text((amount + (amount / disc)).toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Color.fromARGB(255, 210, 55, 31),
                            decoration: TextDecoration.lineThrough,
                          ))
                  : Text(""),
              const SizedBox(
                width: 5,
              ),
              discount!.isNotEmpty
                  ? Text(disc.toString() + "%",
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
