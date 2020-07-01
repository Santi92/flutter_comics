import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:comicbook/src/features/comic/comics/comic_components.dart';
import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/repository/comics_respository_core.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class ComicDetailBloc extends Bloc<ComicDetailBlocEvent, ComicDetailBlocState> {

  final ComicsRepositoryCore _comicsRepository;

  ComicDetailBloc(this._comicsRepository);

  @override
  ComicDetailBlocState get initialState => InitialComicDetailBlocState();

  @override
  Stream<ComicDetailBlocState> mapEventToState(
    ComicDetailBlocEvent event,
  ) async* {

    if(event is LoadCharacteristicEvent){


      final result = await _comicsRepository.getComicDetail(event.comicId);
      final List<ComicComponents> listComponent = await filterComponents(result);

      yield CharacteristicsComicDetailBlocState(components: listComponent);
    }

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
}
