import 'package:comicbook/src/features/comic/comic_base_action.dart';
import 'package:comicbook/src/redux/loading.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:comicbook/src/repository/comics_repository.dart';

class ComicsAction extends ComicBaseActions{

  ComicsRepository _comicsRepository;

  //TODO: DI
  ComicsAction(){
    _comicsRepository = ComicsRepository();
  }

  @override
  Future<AppState> reduce() async {

    final list = await _comicsRepository.getComics();

    return state.copy(
      comicState: comicState.copy(
         newComics: list
      )
    );
  }

  @override
  void before() {
    print("before");
    dispatch(LoadingAction(true));
  }

  @override
  void after() {
    dispatch(LoadingAction(false));
  }
}
