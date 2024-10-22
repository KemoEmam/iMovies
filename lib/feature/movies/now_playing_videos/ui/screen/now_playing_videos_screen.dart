import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';
import '../../../trending/data/model/trending_model.dart';
import '../../logic/now_playing_videos_cubit.dart';
import '../../logic/now_playing_videos_state.dart';

class PlayingVideos extends StatelessWidget {
  const PlayingVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingVideosCubit,
            NowPLayingVideosState<MoviesModel>>(
        builder:
            (BuildContext context, NowPLayingVideosState<MoviesModel> state) {
      return state.when(initial: () {
        return const Center(child: CircularProgressIndicator());
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }, success: (MoviesModel moviesModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing ',
              style: TextStyles.font18WhiteBold,
            ),
            verticalSpacing(20),
            SizedBox(
              height: 200,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ApiConstance.movieId = moviesModel.results![index].id!;

                        context.pushNamed(Routes.movieDetails,
                            arguments: moviesModel.results![index].id!);
                      },
                      child: Container(
                        width: 250,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 75, 75, 75),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${moviesModel.results![index].posterPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  horizentalSpacing(150),
                                  Text(
                                    '⭐ ${moviesModel.results![index].voteAverage!.toStringAsFixed(2)}',
                                    style: TextStyles.font12WhiteSemiBold,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                  height: 5,
                                  width: 170,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 234, 22, 7),
                                  )),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              left: 20,
                              top: 20,
                              child: Icon(
                                Icons.play_circle_outline,
                                color: Colors.grey.shade600,
                                size: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return horizentalSpacing(20);
                  },
                  itemCount: moviesModel.results!.length > 10
                      ? 5
                      : moviesModel.results!.length),
            ),
          ],
        );
      }, error: (String error) {
        return Center(child: Text(error));
      });
    });
  }
}
