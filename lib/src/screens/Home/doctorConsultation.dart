import 'package:flutter/material.dart';

class DoctorConsultation extends StatelessWidget {
  const DoctorConsultation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Radiology")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            // padding: const EdgeInsets.only(
            //   top: 8.0,
            //   left: 8,
            // ),
            child: Text(
              "Thanks for reaching out",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Center(
            // const EdgeInsets.only(bottom: 8.0, left: 8),
            child: Text(
              "We are Coming Soon.....!",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    ));
  }
}
