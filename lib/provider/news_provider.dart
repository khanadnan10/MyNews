import 'package:flutter/cupertino.dart';
import 'package:my_news/model/news.dart';
import 'package:my_news/services/news_services.dart';

class NewsProvider extends ChangeNotifier {
  List<News?>? _news = [];
  bool isLoading = false;
  final NewsServices _services = NewsServices();

  List<News?>? get news => _news;

    Future<void> newsList() async {
    isLoading = true;
    notifyListeners();

    final data = await _services.fetch();
    _news = data;
    isLoading = false;
    notifyListeners();
  }
}
