import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/core/globalServices/db-operation/db_operation_service.dart';

class GitHubRepositoriesScreen extends StatefulWidget {
  @override
  _GitHubRepositoriesScreenState createState() =>
      _GitHubRepositoriesScreenState();
}

class _GitHubRepositoriesScreenState extends State<GitHubRepositoriesScreen> {
  TextEditingController _urlController = TextEditingController();
  TextEditingController _collectionController = TextEditingController();
  TextEditingController _uniqueKeyController = TextEditingController();
  Future<List<dynamic>>? _repositoriesFuture;

  @override
  void initState() {
    super.initState();
    // Initially, load repositories for a default GitHub username.
    // _repositoriesFuture = fetchGitHubRepositories('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "GitHub Repository Work",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Enter GitHub url',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _urlController.clear();
                      },
                      icon: const Icon(Icons.close),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _collectionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Enter collection name',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _collectionController.clear();
                      },
                      icon: const Icon(Icons.close),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _uniqueKeyController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Enter unique key (optional)',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _uniqueKeyController.clear();
                      },
                      icon: const Icon(Icons.close),
                    )),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Fetch repositories for the entered GitHub username.
                    String url = _urlController.text.trim();
                    String collection = _collectionController.text.trim();
                    String uniqueKey = _uniqueKeyController.text.trim();
                    if (url.isNotEmpty) {
                      setState(() {
                        _repositoriesFuture =
                            fetchGitHubRepositories(url, collection, uniqueKey);
                      });
                    }
                  },
                  child: Text("Upload"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    foregroundColor: Theme.of(context).colorScheme.background,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius as needed
                      side: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary), // Set the outline color
                    ),
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

Future<List<dynamic>> fetchGitHubRepositories(url, collection, id) async {
  final response = await http.get(Uri.parse(url));
  print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> dataList = json.decode(response.body);
    dbOperationsService repository = dbOperationsService();
    repository.loadDataList(dataList, collection, id);
    return dataList;
  } else {
    // If the response is not successful, throw an exception.
    throw Exception('Failed to load repositories');
  }
}
