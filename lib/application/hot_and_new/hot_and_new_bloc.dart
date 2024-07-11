import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_new_resp/hot_and_new_service.dart';

import '../../domain/hot_new_resp/model/hot_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  /*
    get hot and new movie data
   */
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.intial()) {
    on<LoadDataInCommingSoon>(
      (event, emit) async {
        //send loadig to ui
        emit(
          const HotAndNewState(
              comingSoonList: [],
              everyOneWatchingList: [],
              isLoading: true,
              hasError: false),
        );
        //get data to state
        final _result = await _hotAndNewService.getHotAndNewMovieData();
        //data to state
        final newState = _result.fold(
          (MainFailure failure) {
            return const HotAndNewState(
              comingSoonList: [],
              everyOneWatchingList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotNewResp resp) {
            return HotAndNewState(
              comingSoonList: resp.results,
              everyOneWatchingList: state.everyOneWatchingList,
              isLoading: false,
              hasError: false,
            );
          },
        );
        emit(newState);
      },
    );
    /*
    get hot and new tv data
   */
    on<LoadDataInEveryoneWatching>(
      (event, emit) async {
        emit(
          const HotAndNewState(
              comingSoonList: [],
              everyOneWatchingList: [],
              isLoading: true,
              hasError: false),
        );
        //get data to state
        final _result = await _hotAndNewService.getHotAndNewTvData();
        //data to state
        final newState = _result.fold(
          (MainFailure failure) {
            return const HotAndNewState(
              comingSoonList: [],
              everyOneWatchingList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotNewResp resp) {
            return HotAndNewState(
              comingSoonList: state.comingSoonList,
              everyOneWatchingList: resp.results,
              isLoading: false,
              hasError: false,
            );
          },
        );
        emit(newState);
      },
    );
  }
}
