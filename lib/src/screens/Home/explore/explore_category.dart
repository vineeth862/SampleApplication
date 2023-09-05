import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filter-test-list.dart';

import '../../../global_service/global_service.dart';
import '../../../utils/Provider/search_provider.dart';

class LabTestCategoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;

  LabTestCategoryCard(this.title, this.content, this.imagePath);
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return GestureDetector(
      onTap: () async {
        await searchState.categoryClicked(title);
        globalservice.navigate(
            context,
            FilteredTestCardlistPage(
              title: title,
              category: content,
            ));
      },
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.10,
              backgroundImage: NetworkImage(imagePath),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.025,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class labPackageCard extends StatelessWidget {
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
        print("Tapped");
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
                          .copyWith(color: Color.fromARGB(193, 27, 8, 1)),
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
