
import 'package:comicbook/src/models/comic_response.dart';
import 'package:comicbook/src/repository/comics_repository.dart';
import 'package:rxdart/rxdart.dart';

class ComicsBloc{

  ComicsRepository _repository = ComicsRepository();
  bool _isGridViewActivated = false;

  final _comicsController = new BehaviorSubject<List<Result>>();

  Stream<List<Result>> get comicsStream =>
      _comicsController.stream;

  void activateGrid(bool activate){
    _isGridViewActivated = activate;
    final list = _comicsController.value;
    _comicsController.sink.add(list);
  }


  void loadComics() async {
    final comics = await _repository.getComics();
    _comicsController.sink.add(comics);
  }

  bool get isGridViewActivated => _isGridViewActivated;

  void dispose(){
    _comicsController.close();
  }


}