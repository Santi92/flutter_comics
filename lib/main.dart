import 'package:comicbook/src/feature_comic_datail/comic_detail_page.dart';
import 'package:comicbook/src/feature_comics/comics_page.dart';
import 'package:comicbook/src/home_page.dart';
import 'package:comicbook/src/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Comic Vine',
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (BuildContext context) => ComicsPage(),
          'comic_detail': (BuildContext context) => ComicDetailPage(),
        },
      ),
    );
  }
}

