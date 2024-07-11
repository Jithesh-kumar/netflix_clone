import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_new_resp/hot_and_new_service.dart';

import '../../domain/hot_new_resp/model/hot_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HotAndNewService _homeService;

  HomeBloc(this._homeService) : super(HomeState.initial()) {
    /**on event get homescreen data */
    on<GetHomeScreenData>(
      (event, emit) async {
        log('Getting Home Screen Data');
        //send loading to ui
        emit(state.copyWith(isLoading: true, hasError: false));
        //get data
        final _movieResult = await _homeService.getHotAndNewMovieData();

        final _tvResult = await _homeService.getHotAndNewTvData();
        //transform data
        final _movieList1 = _movieResult.fold(
          (MainFailure failure) {
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDrammNovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotNewResp resp) {
            final pastYear = resp.results;
            final trending = resp.results;
            final tense = resp.results;
            final southIndian = resp.results;

            pastYear.shuffle();
            trending.shuffle();
            tense.shuffle();
            southIndian.shuffle();
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: pastYear,
              trendingMovieList: trending,
              tenseDrammNovieList: tense,
              southIndianMovieList: southIndian,
              trendingTvList: [],
              isLoading: false,
              hasError: false,
            );
          },
        );
        emit(_movieList1);
        final _tvList2 = _tvResult.fold(
          (MainFailure failure) {
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDrammNovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotNewResp resp) {
            final top10 = resp.results;

            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: state.trendingMovieList,
              tenseDrammNovieList: state.tenseDrammNovieList,
              southIndianMovieList: state.southIndianMovieList,
              trendingTvList: top10,
              isLoading: false,
              hasError: false,
            );
          },
        );
        //send to UI
        emit(_tvList2);
      },
    );
  }
}
