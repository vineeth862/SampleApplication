import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../helper_widgets/confirmation-dialoge.dart';

class ExecutionStackOperation {
  isRemoveWidget(String screen, BuildContext context) async {
    if (screen == 'home') {
      bool flag = await leaveOnConfirmation(context);

      return flag;
    } else
      return true;
  }

  leaveOnConfirmation(context) async {
    bool flag = false;
    await showDialog(
      context: context,
      builder: (BuildContext context1) {
        return Center(
          child: Confirm(
            headerText: "Leaving So Soon?",
            leftBtnText: 'close',
            rightBtnText: 'leave',
            onClick: (click) {
              if (click == 'leave') {
                flag = true;
              } else {
                flag = false;
              }
              Navigator.of(context1).pop();
            },
          ),
        ); // Custom widget for the dialog content
      },
    );

    return flag;
  }
}
