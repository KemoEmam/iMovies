import 'package:clean_architecture_app/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../../../../../core/widgets/custom_movie_banner.dart';
import '../../../../../core/widgets/movie_rate.dart';
import '../../../crew/ui/screen/actor_screem.dart';
import '../../../similar_movie/ui/screen/similar_movie_screen.dart';
import '../../../video/ui/video_screen.dart';
import '../../data/model/movie_details_model.dart';
import '../../logic/movie_details_cubit.dart';
import '../../logic/movie_details_state.dart';
import '../widget/geners_list_vew.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.maindark,
      body: BlocProvider(
        create: (BuildContext context) =>
            getIt<MovieDetailsCubit>()..getMovieDetails(movieId: movieId),
        child: BlocBuilder<MovieDetailsCubit,
            MovieDetailsState<MovieDetailsModel>>(
          builder: (context, state) {
            return state.when(
              initial: () {
                return const Center(child: CircularProgressIndicator());
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              success: (MovieDetailsModel movieDetailsModel) {
                return SingleChildScrollView(
                  child: Column(children: [
                    CustomMovieBanner(
                      bannerImgae:
                          'https://image.tmdb.org/t/p/w500${movieDetailsModel.posterPath}',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              MovieRate(
                                rate:
                                    '⭐ ${movieDetailsModel.voteAverage!.toStringAsFixed(2)}',
                                review:
                                    '(${movieDetailsModel.voteCount} reviews)',
                              ),
                              const Spacer(),
                              Text(
                                '${movieDetailsModel.releaseDate}',
                                style: TextStyles.font12WhiteSemiBold,
                              ),
                            ]),
                            verticalSpacing(15),
                            Text(
                              movieDetailsModel.title!,
                              style: TextStyles.font18WhiteBold,
                              textAlign: TextAlign.start,
                            ),
                            verticalSpacing(20),
                            const GenersListVew(),
                            verticalSpacing(20),
                            Text(
                              movieDetailsModel.overview!,
                              style: TextStyles.font12LightgreySemiBold,
                              textAlign: TextAlign.start,
                            ),
                            verticalSpacing(20),
                            ActorScreen(movieId: movieId),
                            verticalSpacing(30),
                            Center(child: VideoScreen(movieId: movieId)),
                            verticalSpacing(20),
                            SimilarMovieScreen(
                              movieId: movieId,
                            ),
                            verticalSpacing(50),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              },
              error: (error) {
                return Center(child: Text(error));
              },
            );
          },
        ),
      ),
    );
  }
}
