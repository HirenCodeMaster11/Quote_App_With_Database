import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app_with_database/utils/textColor.dart';
import '../Api Helper/api.dart';
import '../Database/database.dart';
import '../Modal/modal.dart';

class QuotesController extends GetxController {
  var quotes = <QuoteModal>[].obs;
  var isLoading = false.obs;
  var likedQuotes = <QuoteModal>[].obs;
  var allQuotes = <QuoteModal>[].obs;
  RxInt selectThemeIndex = 0.obs;
  RxInt screenIndex = 0.obs;
  String bgImage = 'assets/category images/Plain theme/3.jpg';
  RxList<String> selectCatList = <String>[].obs;
  var selectedFont =GoogleFonts.lato();
  Color selectedColor = Colors.white;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void selectCategory(String category) {
    selectCatList.clear();
    if (selectCatList.contains(category)) {
      selectCatList.remove(category);
    } else {
      selectCatList.add(category);
    }
    print('Selected Categories: $selectCatList');
    updateQuotes();
  }

  void updateQuotes() {
    print('Updating Quotes with Categories: $selectCatList');
    if (selectCatList.isEmpty) {
      quotes(allQuotes);
    } else {
      List<QuoteModal> filteredQuotes = allQuotes.where((quote) => selectCatList.contains(quote.category)).toList();
      print('Filtered Quotes: $filteredQuotes');
      quotes(filteredQuotes);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading(true);
    try {
      List<QuoteModal>? result = await ApiHelper.apiHelper.fetchData();
      if (result != null) {
        result.shuffle();
        allQuotes(result); // Store all fetched quotes
        quotes(result); // Initially display all quotes
        print('Fetched Quotes: $result'); // Debugging line
      } else {
        print('Error: No result from API');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }

  void toggleLike(QuoteModal quote, int index) async {
    if (likedQuotes.any((liked) => liked.quote == quote.quote)) {
      likedQuotes.removeWhere((liked) => liked.quote == quote.quote);
      await _databaseHelper.deleteLikedQuote(quote.quote);
    } else {
      likedQuotes.add(quote);
      await _databaseHelper.insertLikedQuote(quote);
    }

    if (quotes[index].isLiked == "1") {
      quotes[index].isLiked = "0";
    } else {
      quotes[index].isLiked = "1";
    }
    update();
    quotes.refresh();
    print(quotes[index].isLiked);
  }

  void loadLikedQuotes() async {
    List<QuoteModal> likedQuotesFromDb = await _databaseHelper.getLikedQuotes();
    likedQuotes.value = likedQuotesFromDb;
  }

  // Group liked quotes by category
  Map<String, List<QuoteModal>> get likedQuotesByCategory {
    var groupedQuotes = <String, List<QuoteModal>>{};
    for (var quote in likedQuotes) {
      if (groupedQuotes.containsKey(quote.category)) {
        groupedQuotes[quote.category]!.add(quote);
      } else {
        groupedQuotes[quote.category] = [quote];
      }
    }
    return groupedQuotes;
  }
}
