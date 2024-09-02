import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Api Helper/api.dart';
import '../Database/database.dart';
import '../Modal/modal.dart';
import '../utils/textColor.dart';

class QuotesController extends GetxController {
  var quotes = <QuoteModal>[].obs;
  var isLoading = false.obs;
  var likedQuotes = <QuoteModal>[].obs;
  var allQuotes = <QuoteModal>[].obs;
  String bgImage = 'assets/category images/Plain theme/3.jpg';
  RxList<String> selectCatList = <String>[].obs;
  var selectedFont = GoogleFonts.lato();
  Color selectedColor = Colors.white;

  void selectedTheme (String theme)
  {
    bgImage = theme;
  }

  void colorPick(int index) {
    selectedColor = colors[index]['color'];
  }

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
      List<QuoteModal> filteredQuotes = allQuotes
          .where((quote) => selectCatList.contains(quote.category))
          .toList();
      print('Filtered Quotes: $filteredQuotes');
      quotes(filteredQuotes);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    initDb();
    readFavouriteQuotes();
    updateQuotesWithLikes();
  }

  void fetchData() async {
    isLoading(true);
    try {
      List<QuoteModal>? result = await ApiHelper.apiHelper.fetchData();
      if (result != null) {
        result.shuffle();
        allQuotes(result);
        quotes(result);
        print('Fetched Quotes: $result');
      } else {
        print('Error: No result from API');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> initDb() async {
    await DatabaseHelper.databaseHelper.database;
  }

  Future<void> insertFavouriteQuotes(QuoteModal quote, int index) async {
    bool isAlreadyAdd = await DatabaseHelper.databaseHelper.isQuoteLiked(quote.quote);

    if (isAlreadyAdd) {
      await removeFavouriteQuotes(quote, index);
    } else {

      quote.isLiked = '1';
      quotes[index].isLiked = '1';
      quotes.refresh();

      await DatabaseHelper.databaseHelper.insertLikedQuote(
        quote.category,
        quote.quote,
        quote.author,
        quote.isLiked,
      );

      Get.snackbar(
        "Success",
        "Quote added to favorites!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xff404040),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16.0),
        borderRadius: 8,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        duration: const Duration(seconds: 2),
      );
    }
    await readFavouriteQuotes();
  }

  Future<void> removeFavouriteQuotes(QuoteModal quote, int index) async {
    quote.isLiked = '0';
    quotes[index].isLiked = '0';
    quotes.refresh();

    await DatabaseHelper.databaseHelper.deleteLikedQuote(quote.id!);

    Get.snackbar(
      "Removed",
      "Quote favorites!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xff404040),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 8,
      icon: const Icon(
        Icons.favorite_border,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 2),
    );

    await readFavouriteQuotes();
  }

  void updateQuotesWithLikes() {
    for (var quote in allQuotes) {
      if (likedQuotes.any((likedQuote) => likedQuote.quote == quote.quote)) {
        quote.isLiked = '1';
      } else {
        quote.isLiked = '0';
      }
    }
    quotes(allQuotes);
    quotes.refresh();
  }

  Future<void> readFavouriteQuotes() async {
    likedQuotes.value = await DatabaseHelper.databaseHelper.readLikedQuotes();
  }

  Future<void> deleteFavouriteQuotes(int id) async {
    await DatabaseHelper.databaseHelper.deleteLikedQuote(id);
    Get.snackbar(
      "Removed",
      "Quote removed from favorites!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xff404040),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 8,
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 2),
    );
    await readFavouriteQuotes();
  }

}
