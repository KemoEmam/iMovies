import 'package:clean_architecture_app/core/networking/api_constants.dart';
import 'package:clean_architecture_app/feature/movies/video/data/model/video_model.dart';
import 'package:clean_architecture_app/feature/movies/video/data/repo/video_repo.dart';
import 'package:clean_architecture_app/feature/movies/video/logic/video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCubit extends Cubit<VideoState<VideoModel>> {
  VideoCubit(this.videoRepo) : super(const VideoState.initial());
  final VideoRepo videoRepo;
  late YoutubePlayerController controller;

  void getVideos({required int movieId}) async {
    emit(const VideoState.loading());
    final data = await videoRepo.getVideoTrailer(queries: {
      'api_key': ApiConstance.apiKey,
    }, movieId: movieId);
    data.when(success: (VideoModel videoModel) {
      emit(VideoState.success(videoModel));
      initializeController(videoModel.results![0].key!);
    }, failure: (error) {
      emit(VideoState.error(error: error.apiErrorModel.statusMessage!));
    });
  }

  void initializeController(String videoId) {
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(mute: false, isLive: false),
    );
  }

  @override
  Future<void> close() {
    controller.dispose(); // Dispose of the controller when the cubit is closed
    return super.close();
  }
}
