import 'package:comicbook/src/bloc.dart';
import 'package:flutter/material.dart';


abstract class BaseState<T extends StatefulWidget, K extends Bloc>
    extends State<T> {

  //AppLocalizations l10n;
  final K bloc;
  Bloc _blocTemp;

  BaseState(this.bloc){
    _blocTemp = bloc;
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _blocTemp.dispose();
    super.dispose();
  }
}