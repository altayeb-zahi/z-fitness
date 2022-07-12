import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String text) onSearch;
  final void Function() onClear;
  final String? hint;

  const SearchBar({
    Key? key,
    required this.onSearch,
    required this.onClear,
    this.hint,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchFoodController = TextEditingController();

  bool showClearIcon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              controller: searchFoodController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearch,
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty) {
                    showClearIcon = false;
                    widget.onClear();
                  } else {
                    showClearIcon = true;
                  }
                });
              },
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (searchFoodController.text.isNotEmpty) {
                      widget.onSearch(searchFoodController.text);
                    }
                  },
                  child: const Icon(Icons.search),
                ),
                hintText: widget.hint ?? 'Search for a food',
                filled: true,
                border: InputBorder.none,
                suffixIcon: showClearIcon
                    ? GestureDetector(
                        onTap: () {
                          if (searchFoodController.text.isNotEmpty) {
                            widget.onClear();
                            searchFoodController.clear();
                          }
                        },
                        child: const Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
