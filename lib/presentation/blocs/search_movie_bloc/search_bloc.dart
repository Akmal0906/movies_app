import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/dara_source/movie_search_data_source.dart';
import '../../../data/models/movie_model.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieSearchRemote movieSearchRemote;

  SearchBloc(this.movieSearchRemote) : super(SearchInitial()) {
    on<SearchNameEvent>(_searchMovie,transformer: debounceSequential(const Duration(seconds: 1)));
    on<SearchInitialEvent>((event, emit) => emit(SearchInitial()));
  }

  void _searchMovie(SearchNameEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final List<MovieModel>? searchList =
        await movieSearchRemote.searchWithCollection(event.movieName);
    emit(searchList == null
        ? const SearchError('Did not found movie')
        : SearchLoaded(searchList));
  }

  EventTransformer<Event> debounceSequential<Event>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
  }
}
