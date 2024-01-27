import 'package:flutter/material.dart';

import '../../core/globalServices/global_service.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  GlobalService globalService = GlobalService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help or Support",
          // style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "CONTACT US",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  globalService.makingPhoneCall("9663383095");
                },
                child: ListTile(
                  title: Text(
                    "+91-9663383095",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  leading: const Icon(
                    Icons.call_outlined,
                    color: Color.fromARGB(255, 48, 158, 77),
                    size: 25,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              // SizedBox(
              //   width: 80,
              // ),
              //Spacer(),
              const Divider(
                thickness: 0.7,
              ),
              GestureDetector(
                onTap: () {
                  globalService.sendEmail("support@medcaph.com", "", "");
                },
                child: ListTile(
                  title: Text(
                    "support@medcaph.com",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  leading: const Icon(
                    Icons.mail_outlined,
                    color: Color.fromARGB(255, 48, 158, 77),
                    size: 25,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
