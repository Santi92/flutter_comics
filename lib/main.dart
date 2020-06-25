import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/feature_comics/comics_page.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:flutter/material.dart';

Store<AppState> store;

void main() {

  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Comic Vine',
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (BuildContext context) => ComicsPagePageConnector(),
        },
      ),
    );
  }
}

