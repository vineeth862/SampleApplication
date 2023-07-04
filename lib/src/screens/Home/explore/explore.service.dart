import '../models/lab.dart';

class ExploreService {
  List<Lab> labList = [
    Lab(name: "lab1", test: ["test1", "test2", "test3", "test4"]),
    Lab(name: "lab2", test: ["test12", "test2", "test4"]),
    Lab(name: "lab3", test: ["test1", "test2", "test3", "test5"]),
    Lab(name: "lab4", test: ["test1", "test7", "test3", "test4"]),
    Lab(name: "lab5", test: ["test12", "test2", "test3", "test4"]),
    Lab(name: "lab6", test: ["test1", "test4"]),
    Lab(name: "lab7", test: ["test1", "test2", "test3", "test4"]),
    Lab(name: "lab8", test: ["test0", "test2", "test3", "test4"]),
    Lab(name: "lab9", test: ["test1", "test2", "test3", "test8"]),
  ];
  List<Lab> cardList = [];
  void clearSearch() {
    // print("Clear Pressed.");
  }

  List<Lab> getSuggetionList(String match) {
    if (match != null && match.trim() != "") {
      return [...labList]
          .where((element) =>
              element.name
                  .toString()
                  .trim()
                  .contains(match.toString().trim()) ||
              element.test
                  .where((element) =>
                      element.toString().contains(match.trim().toString()))
                  .isNotEmpty)
          .toList();
    }
    return labList;
  }

  void filterCardList(List filterdTestList, selectedCard) {
    if (filterdTestList.isNotEmpty) {
      List<Lab> filteredList = [
        ...labList.where((element) => element.test
            .where((element1) => filterdTestList
                .where((element2) => element1 == element2)
                .isNotEmpty)
            .isNotEmpty)
      ];
      filteredList.remove(selectedCard);
      filteredList.insert(0, selectedCard);
      cardList = filteredList;
    } else if (selectedCard != null) {
      cardList = [selectedCard];
    } else {
      cardList = labList;
    }
  }
}
