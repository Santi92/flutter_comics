
import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/redux/app_state.dart';


class LoadingAction extends ReduxAction<AppState> {
  final bool isLoading;

  LoadingAction(this.isLoading);

  @override
  AppState reduce() {
    print("LoadingAction $isLoading");
    return state.copy(isLoading: isLoading);
  }
}
