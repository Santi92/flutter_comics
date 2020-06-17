import 'dart:convert';

import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:http/http.dart' as http;

class ComicsRepository{

  String _urlBase = 'https://comicvine.gamespot.com/api';
  String _apiToken = 'ad7b172fc56c4c6377e3d321480f659a87baebe0';

  Future<List<Result>> getComics() async {
    final url = '$_urlBase/issues?api_key=$_apiToken&format=json';
    final resp = await http.get(url);
    print(resp.body);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final ComicResponse baseResponse = ComicResponse.fromJson(decodedData);


    if (baseResponse.statusCode != 1) return [];

    return baseResponse.results;
  }

  Future<ResultsDetail> getComicDetail(int id) async{
    final url = '$_urlBase/issue/4000-$id/?api_key=$_apiToken&format=json';
    return _executeComic(url);
  }

  Future<ResultsDetail> getComicDetailByUrl(String url) async{
    return _executeComic("$url?api_key=$_apiToken&format=json");
  }

  Future<ResultsDetail> _executeComic(String url) async{

    final resp = await http.get(url);
    print(resp.body);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final ComicDetailRespone baseResponse = ComicDetailRespone.fromJson(decodedData);


    if (baseResponse.statusCode != 1) return null;

    return baseResponse.results;
  }



}