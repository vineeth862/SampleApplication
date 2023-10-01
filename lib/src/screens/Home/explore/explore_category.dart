import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filter-test-list.dart';
import 'package:sample_application/src/screens/category/filtered_category_list.dart';

import '../../../global_service/global_service.dart';
import '../../../utils/Provider/search_provider.dart';
import '../package/package-card-list.dart';

class LabTestCategoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  final List testList;

  LabTestCategoryCard(this.title, this.content, this.imagePath, this.testList);
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return GestureDetector(
      onTap: () {
        // await searchState.categoryClicked("category", title);
        // globalservice.navigate(
        //     context,
        //     FilteredTestCardlistPage(
        //       title: title,
        //       category: content,
        //     ));

        globalservice.navigate(
            context,
            FilterCategoryListPage(
              sexCategory: title,
              testList: testList,
            ));
      },
      child: Card(
        elevation: 0,
        //color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   radius: MediaQuery.of(context).size.width * 0.10,
            //   backgroundImage: NetworkImage(imagePath),
            // ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              //color: Colors.blue,
              // child: ConstrainedBox(
              //   constraints: const BoxConstraints(
              //       maxHeight: 100, minHeight: 50, maxWidth: 100, minWidth: 20),
              //   child: Image.network(imagePath,),
              // ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Set your desired corner radius
                child: Image.network(
                  imagePath, // Replace with your image URL
                  width: 100, // Set your desired width
                  height: 80, // Set your desired height
                  fit: BoxFit.cover, // Set your desired image fit
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class labPackageCard extends StatelessWidget {
  GlobalService globalservice = GlobalService();
  final String? pacName;
  final String? pacDes;
  final String? pacPrice;
  final String? pacFullPrice;
  final String? pacDiscount;
  final String? pacLab;
  labPackageCard(
      {super.key,
      this.pacName,
      this.pacDes,
      this.pacPrice,
      this.pacFullPrice,
      this.pacDiscount,
      this.pacLab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalservice.navigate(context,
            PackageCardlistPage(title: pacName!, category: pacDes.toString()));
      },
      child: Card(
        elevation: 0,
        //color: Theme.of(context).colorScheme.secondaryContainer,
        color: const Color.fromARGB(255, 231, 243, 253),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(pacName.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.bold)
                  //     .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
              const SizedBox(
                height: 5,
              ),
              Text(pacDes.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("₹$pacPrice",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    pacFullPrice.toString(),
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(pacDiscount.toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.error)),
                ],
              ),
              // ConstrainedBox(
              //     constraints: BoxConstraints(
              //         maxHeight: 100,
              //         minHeight: 50,
              //         maxWidth: 100,
              //         minWidth: 20),
              //     child: Container(
              //       child: Image.asset('./assets/images/blood.png',
              //           height: 60, fit: BoxFit.fitWidth),
              //     ))
              const SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Text(
                    "Powered by ",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Expanded(
                    child: Text(
                      pacLab.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: const Color.fromARGB(193, 27, 8, 1)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaleFemaleCategory extends StatelessWidget {
  final Image? image;
  final String? name;
  final String? imagePath;
  const MaleFemaleCategory({super.key, this.image, this.name, this.imagePath});

  @override
  Widget build(BuildContext context) {
    GlobalService globalservice = GlobalService();
    return Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 100, minHeight: 50, maxWidth: 100, minWidth: 20),
              // child: Container(
              //   padding: EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Theme.of(context).colorScheme.secondaryContainer),
              //   child: Image.asset(
              //     imagePath.toString(),
              //     height: 70,
              //     width: 100,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath.toString(),
                  height: 80.0,
                  width: 120.0,
                  fit: BoxFit.fill,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ]),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name.toString()),
              )),
        )
      ],
    ));
  }
}
