import 'package:flutter/material.dart';
import 'package:my_news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsProvider>(context, listen: false).newsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NewsProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
            final newsList = value.news;
            return ListView.builder(
              itemCount: newsList!.length,
              itemBuilder: (BuildContext context, int index) {
                final news = newsList[index];
                return ListTile(
                  title: Text(
                    news!.title.toString(),
                  ),
                  subtitle: Text(news.description.toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
