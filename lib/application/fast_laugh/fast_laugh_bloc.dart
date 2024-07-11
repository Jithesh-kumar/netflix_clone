import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
];

ValueNotifier<Set<int>> likedVideosIdNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo _downloadService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>(
      (event, emit) async {
        //Sending Loading to ui
        emit(
          const FastLaughState(
            videosList: [],
            isError: false,
            isLoading: true,
          ),
        );
        //get trending movies
        final _result = await _downloadService.getDownloadsImage();

        final _state = _result.fold(
          (l) => const FastLaughState(
            videosList: [],
            isError: false,
            isLoading: true,
          ),
          (resp) => FastLaughState(
            videosList: resp,
            isError: false,
            isLoading: false,
          ),
        );
        //send to ui
        emit(_state);
      },
    );
    on<LikeVideo>((event, emit) async {
      likedVideosIdNotifier.value.add(event.id);
      likedVideosIdNotifier.notifyListeners();
    });
    on<UnlikeVideo>((event, emit) async {
      likedVideosIdNotifier.value.remove(event.id);
      likedVideosIdNotifier.notifyListeners();
    });
  }
}
