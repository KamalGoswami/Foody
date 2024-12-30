import 'package:flutter/material.dart';


class SearchSuggestionApp extends StatelessWidget {
  const SearchSuggestionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  // List of suggestions
  final List<Map<String, dynamic>> _suggestions = [
    {"text": "Pizza"},
    {"text": "Burger"},
    {"text": "Noodles"},
    {"text": "Biryani"},
    {"text": "Rolls"},
    {"text": "Paratha"},
    {"text": "Coffee"},
    {"text": "Tea"},
    {"text": "Thali"},
    // Null case
  ];

  // Filtered suggestions
  List<Map<String, dynamic>> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = _suggestions;

    // Listen for text changes in the search bar
    _searchController.addListener(() {
      setState(() {
        String query = _searchController.text.toLowerCase();
        if (query.isEmpty) {
          _filteredSuggestions = _suggestions;
        } else {
          _filteredSuggestions = _suggestions
              .where((suggestion) =>
              suggestion["text"].toLowerCase().contains(query))
              .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
        ),
      ),
      body: _filteredSuggestions.isEmpty
          ? const Center(
        child: Text(
          'Not Found',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _filteredSuggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _filteredSuggestions[index];
          return ListTile(
            leading: Icon(suggestion["icon"], color: Colors.grey),
            title: Text(suggestion["text"]),
            subtitle: (suggestion["category"] != null &&
                suggestion["category"]!.isNotEmpty)
                ? Text(suggestion["category"]!,
                style: const TextStyle(color: Colors.grey))
                : null, // Handle null or empty categories
            trailing: const Icon(Icons.arrow_forward_ios,
                color: Colors.grey, size: 16),
            onTap: () {
              // Handle click on suggestion
              print("Selected: ${suggestion["text"]}");
            },
          );
        },
      ),
    );
  }
}
