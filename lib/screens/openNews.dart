import 'package:flutter/material.dart';

class OpenNews extends StatelessWidget {
  String? title;
  String? image;
  String? content;
  OpenNews({
    super.key,
    this.title,
    this.image,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              title.toString(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(image!),
            Text(
              content!,
              softWrap: true,
            ),
          ],
        ),
      )),
    );
  }
}
