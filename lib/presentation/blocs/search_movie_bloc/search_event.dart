part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

final class SearchNameEvent extends SearchEvent {
  final String movieName;

  const SearchNameEvent(this.movieName);

  @override
  List<Object?> get props => [movieName];
}
final class SearchInitialEvent extends SearchEvent{
  @override
  List<Object?> get props =>[];

}
