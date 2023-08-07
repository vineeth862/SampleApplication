import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  late Function(String title, String labCode, String testCode) onTap;
  final String labCode;
  final String testCode;
  CustomListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap,
      required this.labCode,
      required this.testCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0, 1.0),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          onTap(title, labCode, testCode);
        },
        leading: Icon(icon),
        iconColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
