import 'package:flutter/material.dart';
import 'package:sample_application/src/Home/explore/Search/search_field.dart';

import '../../Home/profile/profile_home.dart';
import '../globalServices/global_service.dart';

class NoOrdersFoundCard extends StatefulWidget {
  final String title;
  NoOrdersFoundCard({required this.title});

  @override
  State<NoOrdersFoundCard> createState() => _NoOrdersFoundCardState();
}

class _NoOrdersFoundCardState extends State<NoOrdersFoundCard>
    with TickerProviderStateMixin {
  GlobalService globalservice = GlobalService();

  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 30,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/empty-cart.jpeg',
            height: 80,
            // color: Color.fromARGB(255, 54, 138, 235),
            // colorBlendMode: BlendMode.color,
          ),
          SizedBox(height: 4.0),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Color.fromARGB(232, 241, 47, 47)),
          ),
          SizedBox(height: 4.0),
          GestureDetector(
            onTap: () {
              globalservice.navigate(context, SearchBarPage());
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Container(
                  width: 250,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            top: 5,
                            left: _animation.value,
                            height: BorderSide.strokeAlignCenter,
                            child: Icon(
                              Icons.arrow_circle_right_rounded,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          );
                        },
                      ),
                      Center(
                        child: Text(
                          'Add Test/Package',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}