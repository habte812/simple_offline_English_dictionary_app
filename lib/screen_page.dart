import 'package:englishdec/about_page.dart';
import 'package:englishdec/detail_page.dart';
import 'package:englishdec/services_page.dart';
import 'package:flutter/material.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  List<DictionaryEntry> _dictionaryEntries = [];
  List<DictionaryEntry> _filteredEntries = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isDarkMode = false;
  @override
  void initState() {
    super.initState();
    _loadDictionary();
  }

  // pages/dictionary_home_page.dart
  Future<void> _loadDictionary() async {
    // Load the dictionary data using DictionaryService
    _dictionaryEntries = await DictionaryService.loadDictionary();

    // Update the filtered list with the full list initially
    setState(() {
      _filteredEntries = _dictionaryEntries;
    });
  }

// pages/dictionary_home_page.dart
  void _filterEntries(String query) {
    setState(() {
      // Filter the dictionary entries that contain the query in their word
      _filteredEntries = _dictionaryEntries.where((entry) {
        return entry.word.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onSearchPressed() {
    _filterEntries(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        body: Column(
          children: [
            Container(
              color: _isDarkMode ? Colors.black : Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isDarkMode ? Icons.sunny : Icons.nightlight_round,
                          color: _isDarkMode ? Colors.yellow : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isDarkMode = !_isDarkMode;
                          });
                        },
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _isDarkMode ? Colors.black : Colors.blue,
                            border: Border.all(
                              color: _isDarkMode ? Colors.white : Colors.white,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            'English Dictionary',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: _isDarkMode ? Colors.white : Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(
                                isdark: _isDarkMode,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Container(
                    padding: const EdgeInsets.fromLTRB(60, 0, 50, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Search for English words',
                              hintStyle: TextStyle(
                                color: _isDarkMode
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30,
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                          onPressed: _onSearchPressed,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredEntries.length,
                itemBuilder: (context, index) {
                  final entry = _filteredEntries[index];

                  return Card(
                    color: _isDarkMode
                        ? const Color.fromARGB(255, 63, 62, 62)
                        : Colors.white,
                    child: ListTile(
                      title: Text(
                        entry.word,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DictionaryDetailPage(entry: entry),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
