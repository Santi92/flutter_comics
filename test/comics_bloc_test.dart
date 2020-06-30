import 'package:bloc_test/bloc_test.dart';
import 'package:comicbook/src/feature_bloc/comics/comics.dart';
import 'package:comicbook/src/repository/comics_repository.dart';
import 'package:comicbook/src/repository/comics_respository_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockComicsRepository extends Mock implements ComicsRepositoryCore {}

void main() {


  group('CounterBloc', () {
    ComicsRepositoryCore repository;
    ComicsBloc comicsBloc;

    setUp(() {
      repository = MockComicsRepository();
      when(repository.getComics()).thenAnswer((_) => Future.value([]));
      comicsBloc = ComicsBloc(comicsRepository: repository);
    });

    test('initial state is ComicsInitial', () {
      expect(comicsBloc.initialState, ComicsInitial());
    });


    blocTest<ComicsBloc, ComicsEvent, ComicsState>(
      'should emit ComicsSuccess and list comics in to an LoadComics event',
      build: () async => comicsBloc,
      act: (bloc) async => bloc.add(LoadComics()),
      expect: <ComicsState>[
        ComicsSuccess(posts: []),
      ],
    );

    tearDown((){
      comicsBloc.close();
    });

  });
}