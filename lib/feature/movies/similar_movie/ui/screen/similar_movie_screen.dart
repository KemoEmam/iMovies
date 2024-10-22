import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/feature/movies/similar_movie/logic/similar_movie_cubit.dart';
import 'package:clean_architecture_app/feature/movies/similar_movie/logic/similar_movie_state.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';

class SimilarMovieScreen extends StatelessWidget {
  const SimilarMovieScreen({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<SimilarMovieCubit>()..getSimilarMovies(movieId: movieId),
      child: BlocBuilder<SimilarMovieCubit, SimmilarMovieState<MoviesModel>>(
        builder: (BuildContext context, SimmilarMovieState<MoviesModel> state) {
          return state.when(initial: () {
            return const Center(child: CircularProgressIndicator());
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, success: (MoviesModel moviesModel) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Similar Movies',
                        style: TextStyles.font18WhiteBold,
                      ),
                    ]),
                verticalSpacing(20),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ApiConstance.movieId =
                                moviesModel.results![index].id!;

                            context.pushNamed(Routes.movieDetails,
                                arguments: moviesModel.results![index].id!);
                          },
                          child: SizedBox(
                            width: 130,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(15),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: moviesModel
                                                .results![index].posterPath !=
                                            null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${moviesModel.results![index].posterPath}')
                                        : CachedNetworkImage(
                                            imageUrl:
                                                'https://ih0.redbubble.net/image.425660345.5511/raf,360x360,075,t,fafafa:ca443f4786.jpg',
                                            height: 120,
                                          ),
                                  ),
                                  moviesModel.results![index].posterPath != null
                                      ? Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Text(
                                            '⭐ ${moviesModel.results![index].voteAverage!.toStringAsFixed(2)}',
                                            style:
                                                TextStyles.font12WhiteSemiBold,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return horizentalSpacing(20);
                      },
                      itemCount: moviesModel.results!.length),
                ),
              ],
            );
          }, error: (error) {
            return Text(error);
          });
        },
      ),
    );
  }
}
