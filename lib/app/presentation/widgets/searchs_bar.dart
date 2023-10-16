import 'package:flutter/material.dart';

class SearchsBar extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onCategorySelected;
  final List<String> selectedCategories;

  // Definir 'allCategories' como una constante estática.
  static const allCategories = ['character', 'episode', 'location'];

  const SearchsBar({
    Key? key,
    required this.onChanged,
    required this.onCategorySelected,
    required this.selectedCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: onCategorySelected,
            itemBuilder: (context) => [
              ...allCategories.map(
                (category) => CheckedPopupMenuItem(
                  value: category,
                  checked: selectedCategories.contains(category),
                  child: Text(category),
                ),
              ),
            ],
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }
}
