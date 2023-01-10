import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_news/model/news.dart';

const apikey = 'ef74b432a8be4356b404b0c3547b74ad';

class NewsServices {
  Future<List<News>> fetch() async {
    var url = 'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apikey';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonString = jsonDecode(response.body);
        List<dynamic> body = jsonString['articles'];
        List<News> news = body.map((dynamic e) => News.fromJson(e)).toList();
        return news;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    throw "Exception Caused!";
  }
}
