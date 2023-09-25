import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/package/package-card-list.dart';
import 'package:sample_application/src/screens/Home/package/packageService.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';

class PackageSuggetionList extends StatefulWidget {
  const PackageSuggetionList({super.key});

  @override
  State<PackageSuggetionList> createState() => _PackageSuggetionList();
}

class _PackageSuggetionList extends State<PackageSuggetionList> {
  PackageService packageService = PackageService();
  @override
  void initState() {
    loadList();
  }

  loadList() async {
    await packageService.loadPackageList();
    setState(() {});
  }

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Package"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: packageService.allPackagesNameList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                globalservice.navigate(
                    context,
                    PackageCardlistPage(
                      category:
                          packageService.allPackagesNameList.elementAt(index),
                      title:
                          packageService.allPackagesNameList.elementAt(index),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 80,
                  child: Card(
                      margin: EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      color:
                          Color.fromARGB(255, 201, 243, 205).withOpacity(0.5),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.medical_services_rounded,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  packageService.allPackagesNameList
                                      .elementAt(index),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
