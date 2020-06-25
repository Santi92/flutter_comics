import 'package:comicbook/src/business/comic_base_action.dart';
import 'package:comicbook/src/redux/app_state.dart';


class LoadingAction extends ComicBaseActions {
  final bool isLoading;

  LoadingAction(this.isLoading);

  @override
  AppState reduce() {
    print("LoadingAction $isLoading");
    return state.copy(isLoading: isLoading);
  }
}
