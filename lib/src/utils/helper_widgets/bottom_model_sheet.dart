import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';

class SwipeableContainer extends StatefulWidget {
  SwipeableContainer({super.key});
  @override
  _SwipeableContainerState createState() => _SwipeableContainerState();
}

class _SwipeableContainerState extends State<SwipeableContainer> {
  double _swipeStartY = 0.0;

  void _onVerticalDragStart(DragStartDetails details) {
    _swipeStartY = details.globalPosition.dy;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _swipeStartY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
    void _onVerticalDragUpdate(DragUpdateDetails details) {
      double dy = details.globalPosition.dy;
      double delta = dy - _swipeStartY;

      if (delta > 80) {
        // Swiping down
        setState(() {
          selectedTest.toggelDetailExpanded();
        });
      }
    }

    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: selectedTest.isDetailExpanded ? 300.0 : 0.0,
        child: Container(
          height: 320.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: selectedTest.isDetailExpanded ? 2 : 0,
                    blurRadius: selectedTest.isDetailExpanded ? 3 : 0,
                    offset: selectedTest.isDetailExpanded
                        ? const Offset(2, 0)
                        : Offset.zero,
                    color: const Color.fromARGB(196, 178, 173, 177))
              ]),
          child: const Padding(
              padding: EdgeInsets.all(16.0), child: Text("Congratulations")),
        ),
      ),
    );
  }
}
