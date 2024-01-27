import 'package:flutter/material.dart';
import 'package:sample_application/src/Home/profile/privacyPolicy.dart';
import 'package:sample_application/src/Home/profile/refundPolicy.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';

class policices extends StatefulWidget {
  const policices({super.key});

  @override
  State<policices> createState() => _policicesState();
}

class _policicesState extends State<policices> {
  GlobalService globalService = GlobalService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Policices"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          ),
          child: Column(
            children: [
              GestureDetector(
                child: ListTile(
                  title: Text("Privacy Policy",
                      style: Theme.of(context).textTheme.headlineMedium),
                  leading: const Icon(Icons.policy),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                onTap: () {
                  globalService.navigate(context, const privacyPolicy());
                },
              ),
              const Divider(
                thickness: 0.8,
              ),
              GestureDetector(
                child: ListTile(
                  title: Text("Refund Policy",
                      style: Theme.of(context).textTheme.headlineMedium),
                  leading: const Icon(Icons.library_books_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                onTap: () {
                  globalService.navigate(context, const RefundPolicy());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
