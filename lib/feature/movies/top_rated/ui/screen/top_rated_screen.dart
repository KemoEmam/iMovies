import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';
import '../../../trending/data/model/trending_model.dart';
import '../../logic/top_rated_cubit.dart';
import '../../logic/top_rated_state.dart';

class TopRatedScreen extends StatelessWidget {
  const TopRatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState<MoviesModel>>(
        builder: (BuildContext context, TopRatedState<MoviesModel> state) {
      if (state is TopRatedStateLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Top Rated',
              style: TextStyles.font18WhiteBold,
            ),
            TextButton(
                onPressed: () {
                  context.pushNamed(Routes.topRated);
                },
                child: const Text(
                  'See All',
                  style: TextStyle(color: Colors.amber),
                ))
          ]),
          verticalSpacing(20),
          SizedBox(
            height: 220,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ApiConstance.movieId = context
                          .read<TopRatedCubit>()
                          .moviesModelList!
                          .results![index]
                          .id!;

                      context.pushNamed(Routes.movieDetails,
                          arguments: context
                              .read<TopRatedCubit>()
                              .moviesModelList!
                              .results![index]
                              .id!);
                    },
                    child: SizedBox(
                      width: 150,
                      child: ClipRRect(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${context.read<TopRatedCubit>().moviesModelList!.results![index].posterPath}'),
                            ),
                            Positioned(
                              top: 0,
                              right: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  " ⭐ ${context.read<TopRatedCubit>().moviesModelList!.results![index].voteAverage!.toStringAsFixed(2)}",
                                  style: TextStyles.font12WhiteBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return horizentalSpacing(20);
                },
                itemCount: context
                    .read<TopRatedCubit>()
                    .moviesModelList!
                    .results!
                    .length),
          ),
        ],
      );
    });
  }
}
