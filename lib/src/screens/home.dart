import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Anthetication/home_signup.dart';
import 'package:sample_application/src/screens/Anthetication/login.dart';
import 'package:sample_application/src/screens/Anthetication/signup.dart';
import 'package:sample_application/src/screens/Search/auto_sugestion_search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onSelectSignup(BuildContext context) {
    //Navigator.of(context).push(route)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const HomeSignup(),
      ),
    );
  }

  void onSelectLogin(BuildContext context) {
    //Navigator.of(context).push(route)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              TextButton(
                onPressed: () {
                  onSelectSignup(context);
                },
                child: Text(
                  'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              TextButton(
                onPressed: () {
                  onSelectLogin(context);
                },
                child: Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                child: AutoSuggestSearchField(),
              ),
            ),
          )),
    );
  }
}
