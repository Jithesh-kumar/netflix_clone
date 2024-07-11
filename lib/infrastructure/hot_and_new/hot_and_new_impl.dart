import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/domain/hot_new_resp/model/hot_new_resp.dart';

import '../../domain/core/apii_end_points.dart';

@LazySingleton(as: HotAndNewService)
class HotAndNewImplementaion implements HotAndNewService {
  @override
  Future<Either<MainFailure, HotNewResp>> getHotAndNewMovieData() async {
    try {
      final response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);
      //  log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotNewResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(
          MainFailure.serverFailure(),
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotNewResp>> getHotAndNewTvData() async {
    try {
      final response = await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);
      //  log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotNewResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(
          MainFailure.serverFailure(),
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
