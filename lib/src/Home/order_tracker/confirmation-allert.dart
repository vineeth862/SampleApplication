import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/Provider/search_provider.dart';
import '../../core/Provider/selected_test_provider.dart';
import '../../core/globalServices/global_service.dart';
import '../explore/Search/Cards/filter-lab-list.dart';
import '../explore/Search/search_field.dart';
import '../package/package-suggetion-list.dart';

class Allert extends StatefulWidget {
  @override
  State<Allert> createState() => _AllertState();
}

class _AllertState extends State<Allert> {
  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
    final searchState = Provider.of<SearchListState>(context);
    GlobalService globalservice = GlobalService();
    return Container(
      width: 400,
      height: 175,
      margin: EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Confirmation',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 4),
              Divider(), // Add a horizontal line to separate title and body
              // SizedBox(height: 8),
              Text(
                'Please Click Test OR Package To Add More Items!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedTest.getSelectedTest.isNotEmpty ||
                          selectedTest.getSelectedPackage.isNotEmpty) {
                        dynamic item = selectedTest.getSelectedPackage.isEmpty
                            ? selectedTest.getSelectedTest.elementAt(0)
                            : selectedTest.getSelectedPackage.elementAt(0);
                        await searchState.cardClicked(item.labCode, false);
                        globalservice.navigate(
                            context,
                            FilteredLabCardlistPage(
                              title: item.labName,
                              labCode: item.labCode,
                              location: "location",
                            ));
                      } else {
                        globalservice.navigate(context, SearchBarPage());
                      }
                    },
                    child: Text('Add Test'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedTest.getSelectedTest.isNotEmpty ||
                          selectedTest.getSelectedPackage.isNotEmpty) {
                        String labCode = selectedTest.getSelectedTest.isNotEmpty
                            ? selectedTest.getSelectedTest.elementAt(0).labCode
                            : selectedTest.getSelectedPackage
                                .elementAt(0)
                                .labCode;
                        globalservice.navigate(
                            context, PackageSuggetionList(labCode: labCode));
                      } else {
                        globalservice.navigate(
                            context, PackageSuggetionList(labCode: ""));
                      }
                    },
                    child: const Text('Add Package'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
