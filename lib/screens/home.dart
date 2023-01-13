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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // Bottom navigation bar to be added here
      body: SafeArea(
        child: Consumer<NewsProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'MN📰',
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            final newsList = value.news;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Top Headlines',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final news = newsList[index];
                      return InkWell(
                        onTap: (() {}),
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image(
                                    height: screenSize.height * 0.13,
                                    width: screenSize.width * 0.3,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        news!.urlToImage.toString())),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    news.title.toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
/*ListTile(
                        leading: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0)),
                            width: screenSize.width * 0.3,
                            height: screenSize.height * 0.3,
                            child: Image(
                              fit: BoxFit.fitWidth,
                              image: news!.urlToImage == null
                                  ? const NetworkImage(
                                      'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                                  : NetworkImage(
                                      news.urlToImage.toString(),
                                    ),
                            )),
                        title: Text(
                          newsList[index]!.title.toString(),
                        ),
                      ); */
