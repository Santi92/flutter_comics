import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/features/comic/comics/comic_components.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:flutter/material.dart';

class ComicDetailViewModel extends BaseModel<AppState>{

  List<ComicComponents> components;
  bool isLoading;

  ComicDetailViewModel();

  ComicDetailViewModel.build({
    @required this.components,
    @required this.isLoading,
  }) : super(equals: [components, isLoading]);

  @override
  ComicDetailViewModel fromStore() => ComicDetailViewModel.build(
    components: state.comicState.comicComponents,
    isLoading: state.isLoading,
  );
}