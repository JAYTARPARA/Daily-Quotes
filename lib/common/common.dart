import 'dart:convert';
import 'package:http/http.dart' as http;

class Common {
  var folderName = "/storage/emulated/0/Daily Quotes/";
  var response;
  var apiGetCategory = 'https://api.quotable.io/tags';
  var apiGetAuthor = 'https://api.quotable.io/authors';
  var apiGetQuotes = 'https://api.quotable.io/quotes';
  var quotesLimit = 50;

  Future getCategories() async {
    try {
      response = await http.get(
        "$apiGetCategory",
      );
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  Future getQuotesByCategory(category, skip) async {
    try {
      response = await http.get(
        "$apiGetQuotes?limit=$quotesLimit&tags=$category&skip=$skip",
      );
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  Future getAuthors() async {
    try {
      response = await http.get(
        "$apiGetAuthor?sortBy=quoteCount&sortOrder=desc",
      );
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  Future getQuotesByAuthor(author, skip) async {
    try {
      response = await http.get(
        "$apiGetQuotes?limit=$quotesLimit&author=$author&skip=$skip",
      );
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }
}
