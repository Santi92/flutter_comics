import 'package:bloc_test/bloc_test.dart';
import 'package:comicbook/src/feature_bloc/comic_detail/bloc.dart';
import 'package:comicbook/src/features/comic/comics/comic_components.dart';
import 'package:comicbook/src/models/comic_datail_response.dart';
import 'package:comicbook/src/repository/comics_respository_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockComicsRepository extends Mock implements ComicsRepositoryCore {}

void main() {
  group('ComicsDetailBloc', () {
    ComicsRepositoryCore repository;
    ComicDetailBloc comicsDetailBloc;

    setUp(() {
      repository = MockComicsRepository();
      when(repository.getComicDetail(0)).thenAnswer((_) => Future.value(
          ResultsDetail(
              characterCredits: [],
              characterDiedIn: [],
              conceptCredits: [],
              locationCredits: [],
              personCredits: [],
              teamCredits: [])));
      when(repository.getComicDetailByUrl(""))
          .thenAnswer((_) => Future.value(ResultsDetail()));
      comicsDetailBloc = ComicDetailBloc(repository);
    });

    test('initial state is InitialComicDetail', () {
      expect(comicsDetailBloc.initialState, InitialComicDetailBlocState());
    });

    blocTest<ComicDetailBloc, ComicDetailBlocEvent, ComicDetailBlocState>(
      'should emit CharacteristicsComicDetail in to an LoadCharacteristic event',
      build: () async => comicsDetailBloc,
      act: (bloc) async => bloc.add(LoadCharacteristicEvent(comicId: 0)),
      expect: <ComicDetailBlocState>[
        CharacteristicsComicDetailBlocState(components: [
          ComicComponents('Characters', []),
          ComicComponents('Teams', []),
          ComicComponents('Locations', []),
          ComicComponents('Concepts', [])
        ])
      ],
    );

    tearDown(() {
      comicsDetailBloc.close();
    });
  });
}
