import 'package:flutter/material.dart';

class HomeCareServices extends StatelessWidget {
  const HomeCareServices({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //     title: Text(
      //   "Home Care Services",
      //   style: Theme.of(context)
      //       .textTheme
      //       .headlineMedium!
      //       .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      // )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),

            Stack(children: [
              // Center(
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(50),
              //     child: Image.asset(
              //       "./assets/images/launching.gif",
              //       //height: MediaQuery.of(context).size.width * ,
              //       width: MediaQuery.of(context).size.width * 0.6,
              //     ),
              //   ),
              // ),
              // Positioned(
              //   child: Text(
              //     "Home Care Servies",
              //     style: Theme.of(context).textTheme.headlineLarge,
              //   ),
              //   left: 10,
              //   right: 10,
              // ),
              Positioned(
                child: Text(
                  "Launching Soon.......!",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                bottom: 0,
                left: 10,
              )
            ]),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "LAUNCHING",
            //     style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            //         color: Theme.of(context).colorScheme.primary, fontSize: 30),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(0.0),
            //   child: Text(
            //     "SOON..!",
            //     style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            //         color: Theme.of(context).colorScheme.primary, fontSize: 30),
            //   ),
            // ),

            // const EdgeInsets.only(bottom: 8.0, left: 8),
            // Container(
            //   width: double.infinity,
            //   color: Color.fromARGB(255, 164, 223, 248),
            //   child: Expanded(
            //     child: Text(
            //       "Coming Soon.....!",
            //       style: Theme.of(context).textTheme.headlineLarge!.copyWith(),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 0.0, right: 0, top: 0),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset(
            //       "./assets/images/coming_soon.png",
            //       height: 150,
            //       width: MediaQuery.of(context).size.width * 1,
            //     ),
            //   ),
            // ),
            SizedBox(height: 0),

            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0, right: 10, top: 0),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset(
            //       "./assets/images/homecare1.png",
            //       //height: MediaQuery.of(context).size.width * ,
            //       width: MediaQuery.of(context).size.width * 1,
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Row(
            //       children: [
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(60),
            //           child: Image.asset(
            //             "./assets/images/Our loved ones are provided.png",
            //             //height: MediaQuery.of(context).size.width * ,
            //             width: MediaQuery.of(context).size.width * 0.25,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(60),
            //           child: Image.asset(
            //             "./assets/images/second.png",
            //             //height: MediaQuery.of(context).size.width * ,
            //             width: MediaQuery.of(context).size.width * 0.25,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(60),
            //           child: Image.asset(
            //             "./assets/images/third.png",
            //             //height: MediaQuery.of(context).size.width * ,
            //             width: MediaQuery.of(context).size.width * 0.25,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "./assets/images/Services to be offered.png",
                  //height: MediaQuery.of(context).size.width * ,
                  width: MediaQuery.of(context).size.width * 1,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
