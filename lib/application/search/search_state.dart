part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required List<SearchResultData> searchResultsList,
    required List<Downloads> idleList,
    required bool isLoading,
    required bool isError,
  }) = _SearchState;
  factory SearchState.intial() => const SearchState(
        searchResultsList: [],
        idleList: [],
        isLoading: false,
        isError: false,
      );
}
