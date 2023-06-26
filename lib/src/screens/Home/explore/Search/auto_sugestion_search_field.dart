import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/screens/Home/models/lab.dart';

// ignore: must_be_immutable
class AutoSuggestSearchField extends StatefulWidget {
  AutoSuggestSearchField({super.key, required this.filterd});

  Function(List match, dynamic clickedCArd) filterd;
  @override
  State<AutoSuggestSearchField> createState() => _AutoSuggestSearchFieldState();
}

class _AutoSuggestSearchFieldState extends State<AutoSuggestSearchField> {
  ExploreService exploreService = ExploreService();
  GlobalService globalService = GlobalService();

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isInputEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isInputEmpty = _controller.text.isEmpty;
      if (_controller.text.isEmpty) {
        widget.filterd([], null);
      }
    });
  }

  void focusFeild() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Lab>(
      getImmediateSuggestions: true,
      hideOnLoading: true,
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: _focusNode,
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search  Any Labs OR Test',
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.all(0),
          suffixIcon: _isInputEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      widget.filterd([], null);
                    });
                  },
                ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
      scrollController: ScrollController(),
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        hasScrollbar: true,
        constraints:
            BoxConstraints(maxHeight: 200), // Specify the maximum height
      ),
      suggestionsCallback: (pattern) async {
        return exploreService.getSuggetionList(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Center(
            child: Text(
                "${suggestion.name}  ${globalService.listToComaSeparateString(suggestion.test, _controller.text)}",
                textAlign: TextAlign.center),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        );
      },
      onSuggestionSelected: (suggestion) {
        List filteredTest = suggestion.test
            .where((element) =>
                _controller.text.isNotEmpty &&
                element.toString().contains(_controller.text.toString()))
            .toList();
        _controller.text = suggestion.name;
        // _onTextChanged();
        widget.filterd(filteredTest, suggestion);
      },
    );
  }
}
