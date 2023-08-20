import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/screens/Home/explore/Search/search_field.dart';
import 'package:sample_application/src/screens/userAdress/initial_adress.dart';
import 'package:sample_application/src/utils/Provider/address_provider.dart';
import '../../../global_service/global_service.dart';
import '../../../utils/Provider/search_provider.dart';
import 'explore.service.dart';
import 'explore_category.dart';
import 'explore_why-us.dart';

class exploreExp extends StatefulWidget {
  const exploreExp({super.key});

  @override
  State<exploreExp> createState() => _exploreExpState();
}

class _exploreExpState extends State<exploreExp> {
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();
  bool _isAppBarExpanded = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isAppBarExpanded = _scrollController.offset > 200.0;
        // Adjust the value as needed
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<UserCurrentLocation>();
    return SafeArea(
      child: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          backgroundColor: Color.fromARGB(255, 243, 242, 243),
          toolbarHeight: 70,
          title: _isAppBarExpanded
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        // padding:
                        //     const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(),
                        child: GestureDetector(
                          onTap: () {
                            globalservice.navigate(
                                context, const SearchBarPage());
                          },
                          child: TextField(
                            decoration: InputDecoration(
                              iconColor: Theme.of(context).colorScheme.primary,
                              enabled: false,
                              hintText: 'Search for Lab/Tests',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              contentPadding: EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.ac_unit_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                )
              : Container(),
          expandedHeight: !_isAppBarExpanded ? 60.0 : 0.0,
          flexibleSpace: FlexibleSpaceBar(
            background: !_isAppBarExpanded
                ? SafeArea(
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 250, 250, 250),
                          Color.fromARGB(255, 246, 245, 246),
                          Color.fromARGB(255, 249, 249, 249),
                          Color.fromARGB(255, 251, 249, 251),
                          //Color.fromARGB(255, 5, 84, 8)
                        ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20),
                            //   child: Text(
                            //     "You are at",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .titleLarge!
                            //         .copyWith(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .primary),
                            //   ),
                            // ),

                            TextButton.icon(
                                onPressed: () {
                                  globalservice.navigate(
                                      context, InitialAdress());
                                },
                                icon: Icon(Icons.location_on),
                                label: Obx(() => Text(
                                      myController.globalString.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                    ))),
                            SizedBox(
                              height: 10,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: MySlider(),
                            // )
                          ],
                        )),
                  )
                : Container(),
          ),
          floating: true,
          pinned: true,
          centerTitle: false,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: MySlider(),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(),
                  child: GestureDetector(
                    onTap: () {
                      globalservice.navigate(context, const SearchBarPage());
                    },
                    child: TextField(
                      decoration: InputDecoration(
                        enabled: false,
                        hintText: 'Search for Lab/Tests',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 340,
                    // padding: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                      './assets/images/flask.jpg',
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Popular test",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio:
                                  0.8, // Adjust the aspect ratio to control the card height
                              children: [
                                LabTestCategoryCard('Blood Tests', '',
                                    './assets/images/blood.png'),
                                LabTestCategoryCard('Urin Tests', '',
                                    './assets/images/urin-test.avif'),
                                LabTestCategoryCard('cogh test', '',
                                    './assets/images/cogh.jpg'),
                                LabTestCategoryCard('metabolic test', '',
                                    './assets/images/test1.jpg'),
                                LabTestCategoryCard('covid -19', '',
                                    './assets/images/corona.jpg'),
                                LabTestCategoryCard('Thyroid panel', '',
                                    './assets/images/test1.jpg'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MySlider(),
                SizedBox(
                  height: 25,
                ),
                Card(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: Image.asset('./assets/images/lab1.png',
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Popular lab",
                                  style:
                                      Theme.of(context).textTheme.displayLarge),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: 80 /
                                  20, // Adjust the aspect ratio to control the card height
                              children: [
                                Container(
                                  child: Image.asset(
                                    './assets/images/lab-logo1.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    './assets/images/lab-logo2.jpeg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    './assets/images/lab-log3.jpeg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    './assets/images/lab-log4.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    './assets/images/lab-log5.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    './assets/images/lab-log6.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MySlider(),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ]))
      ]),
    );
  }
}
