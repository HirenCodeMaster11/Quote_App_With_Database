import 'dart:math';

import 'package:get/get.dart';
import 'package:quote_app_with_database/Api%20Helper/api.dart';
import 'package:quote_app_with_database/Database/database.dart';
import 'package:quote_app_with_database/Modal/modal.dart';

class QuotesController extends GetxController {

  var quotes = <QuoteModal>[].obs;
  var isLoading = false.obs;
  var likedQuotes = <QuoteModal>[].obs;
  var allQuotes = <QuoteModal>[].obs;
  RxInt selectThemeIndex = 0.obs;
  RxInt screenIndex = 0.obs;
  String bgImage = 'assets/category images/Plain theme/3.jpg';
  RxList<String> selectCatList = <String>[].obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void changeIndex(int index) {
    screenIndex.value = index;
  }

  void selectedTheme() {
    update();
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
      List<QuoteModal> filteredQuotes = allQuotes.where((quote) => selectCatList.contains(quote.category)).toList();
      print('Filtered Quotes: $filteredQuotes');
      quotes(filteredQuotes);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    // loadLikedQuotes();
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

  void fetchDataByCategory(String category) {
    isLoading(true);
    try {
      List<QuoteModal> filteredQuotes = allQuotes.where((quote) => quote.category == category).toList();
      quotes(filteredQuotes);
    } catch (e) {
      print('Error filtering data by category: $e');
    } finally {
      isLoading(false);
    }
  }

  void randomQuote()
  {
    RxList<QuoteModal> randomList =quotes;
    randomList.shuffle();
    quotes(randomList);
  }
}
