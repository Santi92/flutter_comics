
import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/models/comic_response.dart';

abstract class ComicsRepositoryCore {

  Future<List<Result>> getComics();

  Future<ResultsDetail> getComicDetail(int id);

  Future<ResultsDetail> getComicDetailByUrl(String url);

}