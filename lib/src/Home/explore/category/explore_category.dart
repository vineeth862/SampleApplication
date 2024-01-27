import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/explore/category/filtered_category_list.dart';
import '../../../core/Provider/search_provider.dart';
import '../../../core/globalServices/global_service.dart';

class LabTestCategoryCard extends StatefulWidget {
  final String title;
  final String content;
  final String imagePath;
  final List testList;

  LabTestCategoryCard(this.title, this.content, this.imagePath, this.testList);

  @override
  State<LabTestCategoryCard> createState() => _LabTestCategoryCardState();
}

class _LabTestCategoryCardState extends State<LabTestCategoryCard> {
  GlobalService globalservice = GlobalService();

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return GestureDetector(
      onTap: () {
        globalservice.navigate(
            context,
            FilterCategoryListPage(
              sexCategory: widget.title,
              testList: widget.testList,
            ));
      },
      child: Padding(
        padding: EdgeInsets.all(
            MediaQuery.of(context).size.width > 500 ? 16.0 : 0.0),
        child: Card(
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Set your desired corner radius
                    child: Image.memory(
                      globalservice.getImageByteCode(widget.imagePath),
                      // height: 80.0,
                      // width: 120.0,
                      fit: BoxFit
                          .fill, // Adjust this to control the image size within its parent widget
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.title,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class MaleFemaleCategory extends StatelessWidget {
  final String? title;
  final String? imagePath;
  final List? testList;
  const MaleFemaleCategory(
      {super.key, this.title, this.imagePath, this.testList});

  @override
  Widget build(BuildContext context) {
    GlobalService globalservice = GlobalService();
    return GestureDetector(
        onTap: () {
          globalservice.navigate(
              context,
              FilterCategoryListPage(
                sexCategory: title,
                testList: testList,
              ));
        },
        // child: Card(
        //     child: Stack(
        //   children: [
        //     Expanded(
        //       child: Container(
        //         decoration:
        //             BoxDecoration(borderRadius: BorderRadius.circular(20)),
        //         child: ClipRRect(
        //           borderRadius:
        //               BorderRadius.circular(10), // Set your desired corner radius
        //           child: Image.memory(
        //             globalservice.getImageByteCode(imagePath),
        //             // height: 80.0,
        //             // width: 120.0,
        //             fit: BoxFit
        //                 .fill, // Adjust this to control the image size within its parent widget
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 5,
        //     ),
        //     Container(
        //         width: double.infinity,
        //         alignment: Alignment.center,
        //         height: 20,
        //         child:
        //             Text(title!, style: Theme.of(context).textTheme.titleMedium)),
        //     //   Expanded(
        //     //     child: Padding(
        //     //       padding: const EdgeInsets.only(top: 4.0),
        //     //       child: ClipRRect(
        //     //         borderRadius: BorderRadius.circular(10.0),
        //     //         child: Image.memory(
        //     //           globalservice.getImageByteCode(imagePath),
        //     //           // height: 80.0,
        //     //           // width: 120.0,
        //     //           fit: BoxFit
        //     //               .fill, // Adjust this to control the image size within its parent widget
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ),
        //     //   Expanded(
        //     //     child: Padding(
        //     //       padding: const EdgeInsets.all(4.0),
        //     //       child: Container(
        //     //           decoration: BoxDecoration(
        //     //               gradient: LinearGradient(colors: [
        //     //                 Theme.of(context).colorScheme.secondaryContainer,
        //     //                 Theme.of(context).colorScheme.secondaryContainer,
        //     //               ]),
        //     //               borderRadius: BorderRadius.circular(10)),
        //     //           child: Padding(
        //     //             padding: const EdgeInsets.all(8.0),
        //     //             child: Text(
        //     //               "      " + title.toString() + "      ",
        //     //               style: Theme.of(context).textTheme.bodyLarge,
        //     //             ),
        //     //           )),
        //     //     ),
        //     //   )
        //   ],
        // )),

        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 90, // 85% of the available space for the image
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.memory(
                      globalservice.getImageByteCode(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              // Spacer(), // To push the text to the bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.width > 500 ? 30 : 30,
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer, // Example background color for text
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black, // Example text color
                        ),
                  ),
                ),

                //   child: Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: Container(
                //         decoration: BoxDecoration(
                //             gradient: LinearGradient(colors: [
                //               Theme.of(context).colorScheme.secondaryContainer,
                //               Theme.of(context).colorScheme.secondaryContainer,
                //             ]),
                //             borderRadius: BorderRadius.circular(10)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             "      " + title.toString() + "      ",
                //             style: Theme.of(context).textTheme.bodyLarge,
                //           ),
                //         )),
                //   ),
              ),
            ],
          ),
        ));
  }
}
