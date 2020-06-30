

import 'package:comicbook/src/features/comic/comics/comic_components.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:flutter/cupertino.dart';

class ComicState{

  List<Result> comics;
  Result comicSelected;
  List<ComicComponents> comicComponents;

  ComicState({
      @required this.comics,
      @required this.comicSelected,
      @required this.comicComponents});

  ComicState copy({List<Result> newComics, Result comic,
    List<ComicComponents> comicComponents}) =>

      ComicState(
        comics: newComics ?? this.comics,
        comicSelected: comic ?? this.comicSelected,
        comicComponents: comicComponents ?? this.comicComponents,
      );

  static ComicState initialState() => ComicState(
    comics: [],
    comicSelected: null,
    comicComponents: null
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicState &&
          runtimeType == other.runtimeType &&
          comics == other.comics &&
          comicSelected == other.comicSelected &&
          comicComponents == other.comicComponents;

  @override
  int get hashCode =>
      comics.hashCode ^ comicSelected.hashCode ^ comicComponents.hashCode;
}