
import 'package:comicbook/src/models/comic_response.dart';
import 'package:equatable/equatable.dart';

abstract class ComicsState extends Equatable {

  const ComicsState();

  @override
  List<Object> get props => [];
}

class ComicsInitial extends ComicsState {}

class ComicsSuccess extends ComicsState {

  final List<Result> posts;

  const ComicsSuccess({
    this.posts,
  });

  ComicsSuccess copyWith({
    List<Result> posts,
  }) {
    return ComicsSuccess(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];

  @override
  String toString() =>
      'PostSuccess { posts: ${posts?.length??0}}';
}