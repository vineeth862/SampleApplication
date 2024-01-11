import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/explore/Search/search_field.dart';
import 'package:sample_application/src/Home/explore/explore_packages.dart';
import 'package:sample_application/src/Home/explore/slider_test_details.dart';
import 'package:sample_application/src/Home/models/category/category.dart';
import 'package:sample_application/src/Home/models/lab/labMasterData.dart';
import 'package:sample_application/src/Home/order_tracker/orderTracker_home.dart';
import 'package:sample_application/src/Home/profile/profile_home.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/initial_adress.dart';

import '../../core/Provider/search_provider.dart';
import '../../core/globalServices/authentication/user_repository.dart';
import '../../core/globalServices/global_service.dart';
import '../order_tracker/order-repository.dart';
import 'Search/Cards/filter-test-list.dart';
import 'category/explore_category.dart';
import 'explore.service.dart';
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
  List<LabTestCategoryCard> categoryList = [];
  List<MaleFemaleCategory> maleCategoryList = [];
  List<MaleFemaleCategory> femaleCategoryList = [];
  late SearchListState searchState;
  final orderRepo = OrderRepository();
  List labList = [];
  int cartCount = 0;
  @override
  void initState() {
    getCartCount();
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _isAppBarExpanded = _scrollController.offset > 200.0;
        // Adjust the value as needed
      });
    });
    getCategoryList();
    getLabLogoList();
    getMaleCategoryList();
    getFemaleCategoryList();
  }

  getCartCount() async {
    final orderIds = await UserRepository().getOrderIds();

    await orderRepo.fetchAllOrders(orderIds, 'cart');
    setState(() {});
  }

  getCategoryList() async {
    List<Category> list = await exploreService.fetchCategoryList();

    for (var i = 0; i < list.length; i++) {
      // var path = await storage.getImageRef(list[i].path!);
      categoryList.add(LabTestCategoryCard(
          list[i].title!, "", list[i].path!, list[i].testList!));
    }

    setState(() {
      categoryList = [...categoryList];
    });
  }

  getMaleCategoryList() async {
    List<Category> list = await exploreService.fetchMaleCategoryList();

    for (var i = 0; i < list.length; i++) {
      // var path = await storage.getImageRef(list[i].path!);

      maleCategoryList.add(MaleFemaleCategory(
        title: list[i].title!,
        imagePath: list[i].path!,
        testList: list[i].testList!,
      ));
    }

    setState(() {
      maleCategoryList = [...maleCategoryList];
    });
  }

  getFemaleCategoryList() async {
    List<Category> list = await exploreService.fetchFemaleCategoryList();

    for (var i = 0; i < list.length; i++) {
      // var path = await storage.getImageRef(list[i].path!);
      femaleCategoryList.add(MaleFemaleCategory(
        title: list[i].title!,
        imagePath: list[i].path!,
        testList: list[i].testList!,
      ));
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
    //globalservice.showLoader();

    return SafeArea(
      child: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          //backgroundColor: const Color.fromARGB(255, 243, 242, 243),
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 100,
                          minHeight: 50,
                          maxWidth: 100,
                          minWidth: 20,
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            './assets/images/MedCapH.jpg',
                          ),
                          radius: 20,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          expandedHeight: !_isAppBarExpanded ? 70.0 : 0.0,
          flexibleSpace: FlexibleSpaceBar(
            background: !_isAppBarExpanded
                ? SafeArea(
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Theme.of(context).colorScheme.surface,
                          Theme.of(context).colorScheme.surface,
                          //Color.fromARGB(255, 5, 84, 8)
                        ])),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 180,
                                height: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    globalservice.navigate(
                                        context, const InitialAdress());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 1, vertical: -1),
                                        contentPadding: const EdgeInsets.only(
                                            left: 5, right: 23),
                                        title: Text(
                                          "Choose Location",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                        ),
                                        subtitle: Obx(() => Text(
                                            myController
                                                .addressToBeConsidered.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium)),
                                        trailing: Container(
                                          width: 30,
                                          alignment:
                                              AlignmentDirectional(-10, 0.9),
                                          child: Icon(
                                              Icons.keyboard_arrow_down_sharp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  globalservice.navigate(
                                      context,
                                      OrderTrackerHome(
                                        from: 'cart',
                                      ));
                                },
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 252, 252, 252),
                                  padding: const EdgeInsets.all(20),
                                  child: badges.Badge(
                                    badgeContent: Text(
                                      orderRepo.orderList.length.toString(),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    showBadge: true,
                                    badgeAnimation: badges.BadgeAnimation.slide(
                                        animationDuration: Duration(
                                          seconds: 1,
                                        ),
                                        curve: Curves.bounceInOut),
                                    child: Icon(Icons.shopping_cart),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
            padding: const EdgeInsets.all(8.0),
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
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
                  height: 5,
                ),
                AspectRatio(
                  aspectRatio:
                      MediaQuery.of(context).size.width > 500 ? 2 : 1.2,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Popular Categories",
                            style: Theme.of(context).textTheme.headlineMedium),
                        subtitle: Text(
                          "MedCapH recomended Health Categories",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: MediaQuery.of(context).size.width >
                                  500
                              ? 1.5
                              : 1, // Adjust the aspect ratio to control the card height
                          children: [...categoryList],
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   width: MediaQuery.sizeOf(context).width * 0.9,
                //   height: MediaQuery.sizeOf(context).height * 0.35,
                //   child: Center(
                //     child: GridView.count(
                //       crossAxisCount:
                //           MediaQuery.sizeOf(context).width > 500 ? 6 : 3,
                //       mainAxisSpacing: 0.0,
                //       crossAxisSpacing: 0.0,
                //       physics: const NeverScrollableScrollPhysics(),
                //       childAspectRatio:
                //           1, // Adjust the aspect ratio to control the card height
                //       children: [...categoryList],
                //     ),
                //   ),
                // ),

                Align(
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Text("Popular Health Packages",
                        style: Theme.of(context).textTheme.headlineMedium),
                    subtitle: Text(
                      "MedcapH recomended health packages",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const PackageSlider(),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: ListTile(
                //     title: Text("Test/Packages for Men",
                //         style: Theme.of(context).textTheme.headlineMedium),
                //     subtitle: Text(
                //       "Highly Prescribed test and packages by doctor",
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     ),
                //   ),
                // ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [...maleCategoryList],
                //   ),
                // ),
                AspectRatio(
                  aspectRatio:
                      MediaQuery.of(context).size.width > 500 ? 2.3 : 2,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Test/Packages for Men",
                            style: Theme.of(context).textTheme.headlineMedium),
                        subtitle: Text(
                          "Highly Prescribed test and packages by doctor",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: MediaQuery.of(context).size.width >
                                  500
                              ? 4 / 4
                              : 1, // Adjust the aspect ratio to control the card height
                          children: [...maleCategoryList],
                        ),
                      ),
                    ],
                  ),
                ),

                AspectRatio(
                  aspectRatio:
                      MediaQuery.of(context).size.width > 500 ? 2.3 : 2,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Test/Packages for Women",
                            style: Theme.of(context).textTheme.headlineMedium),
                        subtitle: Text(
                          "Highly Prescribed test and packages by doctor",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: MediaQuery.of(context).size.width >
                                  500
                              ? 4 / 4
                              : 1, // Adjust the aspect ratio to control the card height
                          children: [...femaleCategoryList],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: ListTile(
                //     title: Text("Test/Packages for Women",
                //         style: Theme.of(context).textTheme.headlineMedium),
                //     subtitle: Text(
                //       "Highly Prescribed test and packages by doctor",
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     ),
                //   ),
                // ),

                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [...femaleCategoryList],
                //   ),
                // ),
                // const SizedBox(
                //   height: 25,
                // ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    //imagePath.toString(),
                    "./assets/images/How Medcaph Works (1).png",
                    // height: MediaQuery.of(context).size.height * 0.7,
                    // width: MediaQuery.of(context).size.height * 0.41,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: AspectRatio(
                //       aspectRatio: 4 / 3,
                //       child: Column(
                //         children: [
                //           Align(
                //             alignment: Alignment.centerLeft,
                //             child: AspectRatio(
                //               aspectRatio: 4 / 0.75,
                //               child: Row(
                //                 children: [
                //                   Image.asset('./assets/images/lab1.png',
                //                       fit: BoxFit.cover),
                //                   const SizedBox(
                //                     width: 20,
                //                   ),
                //                   Align(
                //                     alignment: Alignment.centerLeft,
                //                     child: Text("Choose Most Trusted Labs",
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .headlineMedium),
                //                   ),
                //                   const SizedBox(
                //                     height: 20,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 30,
                //           ),
                //           Expanded(
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: GridView.count(
                //                 crossAxisCount: 3,
                //                 mainAxisSpacing: 20,
                //                 crossAxisSpacing: 20,
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 childAspectRatio: 16 /
                //                     9, // Adjust the aspect ratio to control the card height
                //                 children: [...labList],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                ListTile(
                  title: Text("Know about Tests",
                      style: Theme.of(context).textTheme.headlineMedium),
                  subtitle: Text(
                    "Information about popular test profiles",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                MySliderTest(),
                const SizedBox(
                  height: 25,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ]))
      ]),
    );
  }
}
