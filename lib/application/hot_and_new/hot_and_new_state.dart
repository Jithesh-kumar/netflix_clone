part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required final List<HotAndNewData> comingSoonList,
    required final List<HotAndNewData> everyOneWatchingList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;
  factory HotAndNewState.intial() => const HotAndNewState(
        comingSoonList: [],
        everyOneWatchingList: [],
        isLoading: false,
        hasError: false,
      );
}
