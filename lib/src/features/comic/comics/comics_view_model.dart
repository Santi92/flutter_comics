import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/features/comic/comics/comics_action.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:flutter/material.dart';

class ComicsViewModel extends BaseModel<AppState> {
  List<Result> comics;
  bool isLoading;
  VoidCallback onGetComics;

  ComicsViewModel();

  ComicsViewModel.build(
      {@required this.comics,
      @required this.isLoading,
      @required this.onGetComics})
      : super(equals: [comics, isLoading]);

  @override
  ComicsViewModel fromStore() => ComicsViewModel.build(
      comics: state.comicState.comics,
      isLoading: state.isLoading,
      onGetComics: () => dispatch(ComicsAction()));
}
