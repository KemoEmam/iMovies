import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import '../../trending/data/model/trending_model.dart';
import '../data/repo/now_pllaying_videos_repo.dart';
import 'now_playing_videos_state.dart';

class NowPlayingVideosCubit extends Cubit<NowPLayingVideosState<MoviesModel>> {
  NowPlayingVideosCubit(this.nowPLayingVideosRepo)
      : super(const NowPLayingVideosState.initial());
  final NowPLayingVideosRepo nowPLayingVideosRepo;

  Future<void> getNowPlayingVideos() async {
    emit(const NowPLayingVideosState.loading());

    final data = await nowPLayingVideosRepo.getPlayingVideos(queries: {
      'api_key': ApiConstance.apiKey,
    });
    data.when(success: (MoviesModel moviesModel) {
      emit(NowPLayingVideosState.success(moviesModel));
    }, failure: (error) {
      print(error);
      emit(NowPLayingVideosState.error(
          error: error.apiErrorModel.statusMessage!));
    });
  }
}
