
import 'package:comicbook/src/bloc.dart';
import 'package:comicbook/src/feature_comic_datail/comic_components.dart';
import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/repository/comics_repository.dart';
import 'package:rxdart/rxdart.dart';

class ComicDetailBloc extends Bloc{

  int comicId;
  ComicsRepository _repository = ComicsRepository();

  final _comicController = new BehaviorSubject<List<ComicComponents>>();
  Stream<List<ComicComponents>> get comicsStream =>
      _comicController.stream;

  final _pictureUrlController = new BehaviorSubject<String>();
  Stream<String> get urlStream =>
      _pictureUrlController.stream;


 loadComic(int id) async{
      comicId = id;
      final result = await _repository.getComicDetail(comicId);

      final List<ComicComponents> listComponent = filterComponents(result);

      if(!_comicController.isClosed)
        _comicController.sink.add(listComponent);

  }

  List<ComicComponents> filterComponents(ResultsDetail resultsDetail){
    final List<ComicComponents> listComponent = [];

    listComponent.add(
      ComicComponents(
          'Characters',
          filterSubItem(resultsDetail.characterCredits)
      ));

    listComponent.add(
        ComicComponents(
            'Teams',
            filterSubItem(resultsDetail.teamCredits)
        ));

    listComponent.add(
        ComicComponents(
            'Locations',
            filterSubItem(resultsDetail.locationCredits)
        ));

    listComponent.add(
        ComicComponents(
            'Concepts',
            filterSubItem(resultsDetail.conceptCredits)
        ));

    return listComponent;

  }

  List<Component> filterSubItem(List<Volume> volumes){
    List<Component> components = [];

    volumes.forEach((element) {
       // components.add(Component(element.apiDetailUrl, element.name));
    });

    return components;
  }

  void getPictureUrl(String url) async {
    //final result = await _repository.getComicDetailByUrl(url);
    //_pictureUrlController.sink.add(result.image.iconUrl);
  }

  @override
  void dispose() {
   print("CALLL");
    _comicController.close();
    _pictureUrlController.close();
  }
}