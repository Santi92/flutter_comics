import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/features/comic/comic_state.dart';
import 'package:comicbook/src/redux/app_state.dart';

abstract class ComicBaseActions extends ReduxAction<AppState> {
  ComicState get comicState => state.comicState;
}
