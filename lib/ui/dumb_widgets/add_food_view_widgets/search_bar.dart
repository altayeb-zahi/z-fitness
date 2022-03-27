import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String text) onSearch;
  final void Function() onClear;

  const SearchBar({
    Key? key,
    required this.onSearch,
    required this.onClear,
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
      color: Colors.white,
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
                prefixIcon:  GestureDetector(
                      onTap: () {
                        if (searchFoodController.text.isNotEmpty) {
                          widget.onSearch(searchFoodController.text);
                        }
                      },
                      child: const Icon(Icons.search),
                    ),
                hintText: 'Search for a food',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                
                suffixIcon: showClearIcon?
                  GestureDetector(
                    onTap: () {
                      if (searchFoodController.text.isNotEmpty) {
                        widget.onClear();
                        searchFoodController.clear();
                      }
                    },
                    child: const Icon(Icons.clear),
                  ):null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
