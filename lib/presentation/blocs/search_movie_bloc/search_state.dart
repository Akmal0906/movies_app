part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}
final class SearchLoading extends SearchState{
  @override
  List<Object> get props => [];
}

final class SearchLoaded extends SearchState{
  final List<MovieModel> searchList;
  const SearchLoaded(this.searchList);
  @override
  List<Object> get props => [searchList];
}

final class SearchError extends SearchState{
  final String error;
  const SearchError(this.error);
  @override
  List<Object> get props => [error];
}
