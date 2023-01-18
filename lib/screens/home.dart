import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news/provider/news_provider.dart';
import 'package:my_news/screens/openNews.dart';
import 'package:my_news/utils/snackbar.dart';
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
      // ignore: prefer_const_literals_to_create_immutables
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_rounded),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: "Search",
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Consumer<NewsProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'MN',
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ],
                ),
              );
            }
            final newsList = value.news;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Icon(
                        Icons.menu,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Discover',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'News from all over India',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        onTap: () => snackbar(context, 'Yet to work upon...'),
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          focusColor: Colors.red,
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            fontSize: 18.0,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          suffixIcon: const Icon(Icons.tune_rounded),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                        ),
                      )
                    ],
                  ),
                ),
                // End of Header aka navbar
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    'Top Headlines',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final news = newsList[index];
                      return GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OpenNews(
                                        title: news.title.toString(),
                                        image: news.description,
                                        content: news.content.toString(),
                                      )));
                        }),
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
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
                                  color: Colors.grey.shade50,
                                  // loadingBuilder:
                                  //     (context, child, loadingProgress) {
                                  //   return SizedBox(
                                  //     height: screenSize.height * 0.13,
                                  //     width: screenSize.width * 0.3,
                                  //     child: Center(
                                  //       child: CircularProgressIndicator(
                                  //         value: loadingProgress
                                  //                     ?.expectedTotalBytes !=
                                  //                 null
                                  //             ? loadingProgress!
                                  //                     .cumulativeBytesLoaded /
                                  //                 loadingProgress
                                  //                     .expectedTotalBytes!
                                  //             : null,
                                  //       ),
                                  //     ),
                                  //   );
                                  // },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12.0)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child:
                                            Icon(Icons.broken_image_outlined),
                                      ),
                                    );
                                  },
                                  image: NetworkImage(news!.urlToImage != null
                                      ? news.urlToImage.toString()
                                      : 'https://picsum.photos/200/300'),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    news.title.toString(),
                                    maxLines: 3,
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
