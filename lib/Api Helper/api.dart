import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:quote_app_with_database/Modal/modal.dart';

class ApiHelper
{
  static ApiHelper apiHelper = ApiHelper._();
  ApiHelper._();

  Future<List<QuoteModal>?> fetchData({String? category}) async {
    String apiData = "https://sheetdb.io/api/v1/wwuy3c8hslitp";
    Uri uri = Uri.parse(apiData);
    Response response = await http.get(uri);

    if (response.statusCode == 200) {
      print('API called successfully');
      List<dynamic> jsonData = json.decode(response.body);
      List<QuoteModal> quotes = jsonData.map((json) => QuoteModal.fromJson(json)).toList();

      if (category != null) {
        quotes = quotes.where((quote) => quote.category == category).toList();
      }
      return quotes;
    }
    return null;
  }
}