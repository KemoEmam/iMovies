import 'package:clean_architecture_app/core/di/dependency_injection.dart';
import 'package:clean_architecture_app/feature/Tv/video/data/model/series_video_model.dart';
import 'package:clean_architecture_app/feature/Tv/video/logic/series_video_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/video/logic/series_video_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeriesVideoScreen extends StatelessWidget {
  const SeriesVideoScreen({super.key, required this.seriesId});
  final int seriesId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<SeriesVideoCubit>()..getVideos(seriesId: seriesId),
      child: BlocBuilder<SeriesVideoCubit, SeriesVideoState<SeriesVideoModel>>(
        builder:
            (BuildContext context, SeriesVideoState<SeriesVideoModel> state) {
          if (state is SeriesVideoStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final cubit = BlocProvider.of<SeriesVideoCubit>(context);
          cubit.initializeController(context
              .read<SeriesVideoCubit>()
              .seriesVideoList!
              .results![0]
              .key!);

          return WillPopScope(
            onWillPop: () async {
              context.read<SeriesVideoCubit>().close();
              return true;
            },
            child: Center(
              child: SizedBox(
                height: 200, // You can adjust the height as needed
                width: double.infinity,
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
      ),
    );
  }
}
