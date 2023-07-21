import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montion_verse/models/dictionary_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class SignLanguageModel extends ChangeNotifier{
  List<SignLanguage> _signLanguages = [];
  List<SignLanguage> _filteredSignLanguages = [];
  List<SignLanguage> get signLanguages => _signLanguages;
  String get searchQuery => _searchQuery;
  String _searchQuery = '';



  void setSignLanguages(List<SignLanguage> signLanguages) {
    _signLanguages = signLanguages;
    _filteredSignLanguages = _signLanguages;
    notifyListeners();
  }
  void filterByDictionaryWord(String searchKeyword) {
    _searchQuery = searchKeyword;

    if (searchKeyword.isEmpty) {
      _filteredSignLanguages = _signLanguages; // Show all data when search keyword is empty
    } else {
      _filteredSignLanguages = _signLanguages.where((signLanguage) {
        return signLanguage.signLanguage.toLowerCase().contains(searchKeyword.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  List<SignLanguage> get filteredSignLanguages => _filteredSignLanguages;
}

