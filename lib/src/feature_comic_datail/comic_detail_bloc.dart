
import 'package:comicbook/src/feature_comic_datail/comic_components.dart';
import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/repository/comics_repository.dart';
import 'package:rxdart/rxdart.dart';

class ComicDetailBloc {

  int comicId;
  ComicsRepository _repository = ComicsRepository();

  final _comicController = new BehaviorSubject<List<ComicComponents>>();
  Stream<List<ComicComponents>> get comicsStream =>
      _comicController.stream;

  final _pictureUrlController = new BehaviorSubject<String>();
  Stream<String> get urlStream =>
      _pictureUrlController.stream;


  void loadComic(int id) async{
    print(comicId);
    print(id);

    if(comicId != id){
      comicId = id;
      final result = await _repository.getComicDetail(comicId);

      //final List<ComicComponents> listComponent = filterComponents(result);

     // _comicController.sink.add(listComponent);
    }


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
        components.add(Component(element.apiDetailUrl, element.name));
    });

    return components;
  }

  void getPictureUrl(String url) async {
    //final result = await _repository.getComicDetailByUrl(url);
    //_pictureUrlController.sink.add(result.image.iconUrl);
  }


  void dispose(){
    _comicController.close();
    _pictureUrlController.close();
  }


}