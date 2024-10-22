import 'package:clean_architecture_app/core/di/dependency_injection.dart';
import 'package:clean_architecture_app/feature/movies/video/data/model/video_model.dart';
import 'package:clean_architecture_app/feature/movies/video/logic/video_cubit.dart';
import 'package:clean_architecture_app/feature/movies/video/logic/video_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<VideoCubit>()..getVideos(movieId: movieId),
      child: BlocBuilder<VideoCubit, VideoState<VideoModel>>(
        builder: (BuildContext context, VideoState<VideoModel> state) {
          return state.when(
            initial: () {
              return const Center(child: CircularProgressIndicator());
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            success: (VideoModel videoModel) {
              final cubit = BlocProvider.of<VideoCubit>(context);
              cubit.initializeController(videoModel.results![0].key!);
              return WillPopScope(
                onWillPop: () async {
                  BlocProvider.of<VideoCubit>(context).close();
                  return true;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AspectRatio(
                    aspectRatio: 25 / 12,
                    child: YoutubePlayer(
                      controller: cubit.controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            error: (error) {
              return Text(error);
            },
          );
        },
      ),
    );
  }
}
