import 'package:clean_architecture_app/core/networking/api_constants.dart';
import 'package:clean_architecture_app/feature/Tv/video/data/model/series_video_model.dart';
import 'package:clean_architecture_app/feature/Tv/video/data/repo/series_video_repo.dart';
import 'package:clean_architecture_app/feature/Tv/video/logic/series_video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeriesVideoCubit extends Cubit<SeriesVideoState<SeriesVideoModel>> {
  SeriesVideoCubit(this.seriesVideoRepo) : super(SeriesVideoStateInitial());
  final SeriesVideoRepo seriesVideoRepo;
  late YoutubePlayerController controller;
  SeriesVideoModel? seriesVideoList;

  void getVideos({required int seriesId}) async {
    emit(SeriesVideoStateLoading());
    final data = await seriesVideoRepo.getSeriesVideoTrailer(queries: {
      'api_key': ApiConstance.apiKey,
    }, seriesId: seriesId);
    data.when(success: (SeriesVideoModel seriesVideoModel) {
      seriesVideoList = seriesVideoModel;
      emit(SeriesVideoStateSuccess(seriesVideoModel));
      initializeController(seriesVideoModel.results![0].key!);
    }, failure: (error) {
      emit(SeriesVideoStateError(error.apiErrorModel.statusMessage!));
    });
  }

  void initializeController(String seriesvideoId) {
    controller = YoutubePlayerController(
      initialVideoId: seriesvideoId,
      flags: const YoutubePlayerFlags(mute: false, isLive: false),
    );
  }

  @override
  Future<void> close() {
    controller.dispose(); // Dispose of the controller when the cubit is closed
    return super.close();
  }
}
