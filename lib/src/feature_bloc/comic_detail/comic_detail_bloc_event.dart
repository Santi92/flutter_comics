import 'package:comicbook/src/features/comic/comics/comic_components.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ComicDetailBlocEvent {}

class LoadCharacteristicEvent extends ComicDetailBlocEvent{
  final int comicId;
  LoadCharacteristicEvent(this.comicId);
}