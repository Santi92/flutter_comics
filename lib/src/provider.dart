import 'package:comicbook/src/feature_comic_datail/comic_detail_bloc.dart';
import 'package:comicbook/src/feature_comics/comics_bloc.dart';
import 'package:flutter/material.dart';


class Provider extends InheritedWidget{

  final _comicsBlock = ComicsBloc();
  final _comicDetailBlock = ComicDetailBloc();
  static Provider _instance;

  factory Provider({Key key, Widget child}){

    if (_instance == null){
      _instance = new Provider._internal(key: key, child: child);
    }

    return _instance;

  }
  
  Provider._internal({Key key, Widget child})
      :super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ComicsBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._comicsBlock;
  }

  static ComicDetailBloc gtComicBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._comicDetailBlock;
  }


}
