import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/business/comics_action.dart';
import 'package:comicbook/src/business/loading.dart';
import 'package:comicbook/src/feature_comic_datail/comic_components.dart';
import 'package:comicbook/src/models/comic_response.dart';
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