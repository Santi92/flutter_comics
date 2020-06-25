import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/business/comics_action.dart';
import 'package:comicbook/src/business/loading.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:flutter/material.dart';

class ComicsViewModel extends BaseModel<AppState>{

  List<Result> comics;
  VoidCallback onGetListComics;
  bool isLoading;

  ComicsViewModel();

  ComicsViewModel.build({
    @required this.comics,
    @required this.onGetListComics,
    @required this.isLoading,
  }) : super(equals: [comics]);

  @override
  ComicsViewModel fromStore() => ComicsViewModel.build(
    comics: state.comicState.comics,
    onGetListComics: () => dispatch(ComicsAction()),
    isLoading: state.isLoading,
  );
}