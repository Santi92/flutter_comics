
import 'package:comicbook/src/features/comic/comic_base_action.dart';
import 'package:comicbook/src/features/comic/comic_detail/comic_components.dart';
import 'package:comicbook/src/redux/loading.dart';
import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:comicbook/src/repository/comics_repository.dart';

class ComicDetailAction extends ComicBaseActions{

  ComicsRepository _comicsRepository;
  final int comicId;

  //TODO: DI
  ComicDetailAction({this.comicId}){
    _comicsRepository = ComicsRepository();
  }

  @override
  Future<AppState> reduce() async {

    final result = await _comicsRepository.getComicDetail(comicId);
    final List<ComicComponents> listComponent = await filterComponents(result);

    return state.copy(
        comicState: comicState.copy(
            comicComponents: listComponent
        )
    );
  }

  Future<List<ComicComponents>> setPictureUrl(List<ComicComponents> listComponent) async {


  }

  Future<List<ComicComponents>> filterComponents(ResultsDetail resultsDetail) async{

    final List<ComicComponents> listComponent = [];

    listComponent.add(
        ComicComponents(
            'Characters',
            await filterSubItem(resultsDetail.characterCredits)
        ));

    listComponent.add(
        ComicComponents(
            'Teams',
            await filterSubItem(resultsDetail.teamCredits)
        ));

    listComponent.add(
        ComicComponents(
            'Locations',
            await filterSubItem(resultsDetail.locationCredits)
        ));

    listComponent.add(
        ComicComponents(
            'Concepts',
            await filterSubItem(resultsDetail.conceptCredits)
        ));

    return listComponent;

  }

  Future<List<Component>> filterSubItem(List<Volume> volumes)async{
    List<Component> components = [];

    for(var volumen in volumes){

      var result = await _comicsRepository.getComicDetailByUrl(volumen.apiDetailUrl);

      components.add(Component(
          volumen.apiDetailUrl,
          volumen.name,
          result.image.iconUrl
      ));
    }



    return components;
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
