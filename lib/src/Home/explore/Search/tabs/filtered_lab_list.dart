import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import '../../../../core/helper_widgets/list_tile.dart';
import '../../../../core/helper_widgets/no_result_found.dart';
import '../Cards/filter-lab-list.dart';

class LabListScreen extends StatelessWidget {
  LabListScreen({super.key});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return searchState.getlabSuggetionList.isEmpty
        ? Center(
            child: SingleChildScrollView(
                child: NoResultFoundCard(
              title: 'No available lab in this search',
            )),
          )
        : Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(12),
                child: searchState.input.isEmpty
                    ? Text(
                        "Popular Labs",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3),
                      )
                    : Text(
                        "Searched Results!",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3),
                      ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchState.getlabSuggetionList.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(
                      title: searchState.getlabSuggetionList[index].labName,
                      icon: ClipOval(
                        child: Container(
                          width: 40,
                          height: 40,
                          //color: Theme.of(context).colorScheme.tertiary,
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black)),
                          child: Image.memory(
                            this.globalservice.getImageByteCode(
                                searchState.getlabSuggetionList[index].logo),
                            fit: BoxFit
                                .contain, // Adjust this to control the image size within its parent widget
                          ),
                        ),
                      ),
                      //subtitle: "lab",
                      labCode: searchState.getlabSuggetionList[index].labCode,
                      testCode: '',
                      onTap: (title, labCode, tesCode) async {
                        await searchState.cardClicked(labCode, false);
                        globalservice.navigate(
                            context,
                            FilteredLabCardlistPage(
                                title: searchState
                                    .getlabSuggetionList[index].labName,
                                location: searchState.getlabSuggetionList[index]
                                    .branchDetails[0].locality,
                                labCode: searchState
                                    .getlabSuggetionList[index].labCode));
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }
}
