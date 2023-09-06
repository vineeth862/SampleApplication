import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/screens/Home/explore/Search/search_field.dart';
import 'package:sample_application/src/screens/Home/explore/explore_howItWorks.dart';
import 'package:sample_application/src/screens/Home/explore/explore_packages.dart';
import 'package:sample_application/src/screens/Home/models/category/category.dart';
import 'package:sample_application/src/screens/Home/models/lab/labMasterData.dart';
import 'package:sample_application/src/screens/userAdress/initial_adress.dart';
import '../../../global_service/cloud_storage_service.dart';
import '../../../global_service/global_service.dart';
import '../../../utils/Provider/search_provider.dart';
import 'Search/Cards/filter-test-list.dart';
import 'explore.service.dart';
import 'explore_category.dart';
import 'explore_why-us.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  CloudStorageService storage = CloudStorageService();
  List<LabTestCategoryCard> categoryList = [];
  late SearchListState searchState;
  List labList = [];
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _isAppBarExpanded = _scrollController.offset > 200.0;
        // Adjust the value as needed
      });
    });
    getCategoryList();
    getLabLogoList();
  }

  getCategoryList() async {
    List<Category> list = await exploreService.fetchCategoryList();

    for (var i = 0; i < list.length; i++) {
      // var path = await storage.getImageRef(list[i].path!);
      categoryList.add(LabTestCategoryCard(list[i].title!, "", list[i].path!));
    }

    setState(() {
      categoryList = [...categoryList];
    });
  }

  getLabLogoList() async {
    List<LabMasterData> list = await exploreService.fetchLabList();

    for (var i = 0; i < list.length; i++) {
      // var path = await storage.getImageRef(list[i].path!);
      labList.add(InkWell(
        onTap: () async {
          await searchState.cardClicked(list[i].labCode!, false);
          globalservice.navigate(
              context,
              FilteredTestCardlistPage(
                title: list[i].title!,
                category: list[i].labCode!,
              ));
        },
        child: Image.network(
          list[i].path!,
          fit: BoxFit.fill,
        ),
      ));
    }

    setState(() {
      labList = [...labList];
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
    searchState = Provider.of<SearchListState>(context);
    return SafeArea(
      child: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromARGB(255, 243, 242, 243),
          toolbarHeight: 70,
          leading: null,
          automaticallyImplyLeading: false,
          title: _isAppBarExpanded
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        // padding:
                        //     const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(),
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
                              contentPadding: const EdgeInsets.all(16),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                        decoration: const BoxDecoration(
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
                            TextButton.icon(
                                onPressed: () {
                                  globalservice.navigate(
                                      context, const InitialAdress());
                                },
                                icon: const Icon(Icons.location_on),
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
                            const SizedBox(
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
                const SizedBox(
                  height: 8,
                ),
                Container(
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(),
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
                        contentPadding: const EdgeInsets.all(16),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  child: Image.asset(
                                      './assets/images/flask.jpg',
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Popular Categories",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio:
                                  0.8, // Adjust the aspect ratio to control the card height
                              children: [...categoryList],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Text("Popular Health Packages",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                      "MedcapH recomended health packages",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const PackageSlider(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Text("Test/Packages for Men",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                      "Highly Prescribed test and packages by doctor",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MaleFemaleCategory(
                        name: "Under 25 Years",
                      ),
                      MaleFemaleCategory(
                        name: "25-50 Years",
                      ),
                      MaleFemaleCategory(
                        name: "Above 50 Years",
                      ),
                      MaleFemaleCategory(
                        name: "All Packages",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Text("Test/Packages for Women",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                      "Highly Prescribed test and packages by doctor",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MaleFemaleCategory(
                        name: "Under 25 Years",
                      ),
                      MaleFemaleCategory(
                        name: "25-50 Years",
                      ),
                      MaleFemaleCategory(
                        name: "Above 50 Years",
                      ),
                      MaleFemaleCategory(
                        name: "All Packages",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("How it Works",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          )),
                    )),

                const HowItWorks(
                    heading: "1. Book Test",
                    description:
                        "Find a Health Test you are looking for from your desired diagnostics."),
                const HowItWorks(
                    heading: "2. Sample Collection",
                    description:
                        "Our Phlebo will collect the sample from your doorstep ensuring the highest safety"),
                const HowItWorks(
                    heading: "3. Get Reports",
                    description:
                        "Test reports can be downloaded easily from Emial and MedCapH"),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AspectRatio(
                              aspectRatio: 4 / 0.75,
                              child: Row(
                                children: [
                                  Image.asset('./assets/images/lab1.png',
                                      fit: BoxFit.cover),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Choose Most Trusted Labs",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
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
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 16 /
                                    9, // Adjust the aspect ratio to control the card height
                                children: [...labList],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //MySlider(),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ]))
      ]),
    );
  }
}
