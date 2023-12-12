import 'package:flutter/material.dart';

class Confirm extends StatefulWidget {
  final String leftBtnText;
  final String rightBtnText;
  final String headerText;
  final Function(String click) onClick;

  Confirm(
      {required this.leftBtnText,
      required this.rightBtnText,
      required this.onClick,
      required this.headerText});
  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 175,
      margin: EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Confirmation',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 4),
              Divider(), // Add a horizontal line to separate title and body
              // SizedBox(height: 8),
              Text(
                widget.headerText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.onClick(widget.leftBtnText);
                      },
                      child: Text(
                        widget.leftBtnText,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Theme.of(context)
                                .colorScheme
                                .inverseSurface; // Default color
                          },
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        widget.onClick(widget.rightBtnText);
                      },
                      child: Text(
                        widget.rightBtnText,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Theme.of(context)
                                .colorScheme
                                .tertiary; // Default color
                          },
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}