// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';

import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_app/domain/search/i_search_repo.dart';

import '../../domain/downloads/models/downloads.dart';
import '../../domain/search/model/search_response/search_response.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadsService;
  final ISearchRepo _searchService;
  SearchBloc(
    this._downloadsService,
    this._searchService,
  ) : super(SearchState.intial()) {
    /**idle state */
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(
          SearchState(
            idleList: state.idleList,
            searchResultsList: [],
            isLoading: false,
            isError: false,
          ),
        );
        return;
      }
      emit(
        const SearchState(
          idleList: [],
          searchResultsList: [],
          isLoading: true,
          isError: false,
        ),
      );

      //get trending
      final _result = await _downloadsService.getDownloadsImage();
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            idleList: [],
            searchResultsList: [],
            isLoading: false,
            isError: true,
          );
        },
        (List<Downloads> list) {
          return SearchState(
            idleList: list,
            searchResultsList: [],
            isLoading: false,
            isError: false,
          );
        },
      );
      //show to ui
      emit(_state);
    });
    /**search result state */
    on<SearchMovie>((event, emit) async {
      //call search movie api
      log('Searching for ${event.movieQuery}'.toString());
      emit(
        const SearchState(
          idleList: [],
          searchResultsList: [],
          isLoading: true,
          isError: false,
        ),
      );

      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            idleList: [],
            searchResultsList: [],
            isLoading: false,
            isError: true,
          );
        },
        (SearchResponse r) {
          return SearchState(
            idleList: [],
            searchResultsList: r.results,
            isLoading: false,
            isError: false,
          );
        },
      );
      //show to ui
      emit(_state);
    });
  }
}
