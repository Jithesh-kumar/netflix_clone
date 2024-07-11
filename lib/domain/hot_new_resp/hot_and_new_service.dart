import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_new_resp/model/hot_new_resp.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotNewResp>> getHotAndNewMovieData();
  Future<Either<MainFailure, HotNewResp>> getHotAndNewTvData();
}
