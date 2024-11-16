import 'dart:convert';

import 'package:flutter/services.dart';
//This class represents a dictionary entry, consisting of a word and its associated definitions.

class DictionaryEntry {
  final String word;
  final List<String> definitions;

  DictionaryEntry({required this.word, required this.definitions});

  // Factory constructor to create a DictionaryEntry from JSON data
  factory DictionaryEntry.fromJson(String word, dynamic json) {
    return DictionaryEntry(
      word: word,
      definitions: List<String>.from(json),
    );
  }
}



//This function loads the dictionary data from the JSON file in the assets and returns it as a list of DictionaryEntry objects.

class DictionaryService {
  // Load dictionary data from JSON file and convert to a list of DictionaryEntry objects
  static Future<List<DictionaryEntry>> loadDictionary() async {
    // Load the JSON file from assets
    final String jsonString = await rootBundle.loadString('assets/file/dictionary.json');
    
    // Decode the JSON string to a Map
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert the Map to a list of DictionaryEntry objects
    List<DictionaryEntry> entries = jsonMap.entries.map((entry) {
      return DictionaryEntry.fromJson(entry.key, entry.value);
    }).toList();

    return entries;
  }
}
