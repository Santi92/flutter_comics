import 'package:comicbook/src/features/comic/comics/comic_components.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ComicDetailBlocState extends Equatable{

  ComicDetailBlocState();
}

class InitialComicDetailBlocState extends ComicDetailBlocState {

  @override
  List<Object> get props {
    return [];
  }
}

class CharacteristicsComicDetailBlocState extends ComicDetailBlocState {

  final List<ComicComponents> components;

  CharacteristicsComicDetailBlocState({this.components});

  @override
  List<Object> get props {
    return [components.length];
  }

  @override
  String toString() =>
      'PostSuccess { posts: ${components.length}}';
}

