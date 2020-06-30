
import 'package:bloc/bloc.dart';
import 'package:comicbook/src/feature_bloc/comics/comics_event.dart';
import 'package:comicbook/src/feature_bloc/comics/comics_state.dart';
import 'package:comicbook/src/repository/comics_repository.dart';
import 'package:flutter/cupertino.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicsRepository comicsRepository;

  ComicsBloc({@required this.comicsRepository});

  @override
  Stream<ComicsState> mapEventToState(ComicsEvent event) async*{

    yield ComicsInitial();

    final data = await comicsRepository.getComics();

    yield ComicsSuccess(posts: data);

  }

  @override
  ComicsState get initialState  => ComicsInitial();
}