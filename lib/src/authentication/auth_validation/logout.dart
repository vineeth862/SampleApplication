import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  bool logoutEnabled = false;
  void showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform logout logic here
                  // For demonstration purposes, we just print a message
                  print('Logged out successfully.');
                  AuthenticationRepository.instance.logout();
                },
                child: Text('Yes, Logout'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    logoutEnabled = false;
                  });
                  Navigator.pop(context);
                  // Close the bottom sheet
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Logout Screen')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      width: 2.0,
                    ),
                    gradient: LinearGradient(colors: [
                      Colors.grey.shade50,
                      Colors.grey.shade100,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Logout',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Switch(
                      value: logoutEnabled,
                      onChanged: (newValue) {
                        setState(() {
                          logoutEnabled = newValue;
                          if (logoutEnabled) {
                            showLogoutConfirmation(context);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
