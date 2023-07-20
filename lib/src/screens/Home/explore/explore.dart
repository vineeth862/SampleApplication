// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/search_field.dart';
import '../../../global_service/global_service.dart';
import '../../../utils/Provider/search_provider.dart';
import 'explore.service.dart';
import 'explore_category.dart';
import 'explore_why-us.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();

  @override
  build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              MySlider(),
              SizedBox(
                height: 25,
              ),
              // search
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                                child: Image.asset('./assets/images/flask.jpg',
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Popular test",
                                  style:
                                      Theme.of(context).textTheme.displayLarge),
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
                              LabTestCategoryCard(
                                  'cogh test', '', './assets/images/cogh.jpg'),
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
            ],
          ),
        ),
      ),
    );
  }
}
