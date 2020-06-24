
import 'package:comicbook/src/bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class BasePage extends StatefulWidget {

  final Bloc bloc;
  final dynamic params;

  BasePage({
    this.params,
    @required this.bloc
});



}