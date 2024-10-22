import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/data/model/top_rated_series_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';
import '../../logic/popular_series_cubit.dart';
import '../../logic/popular_series_state.dart';

class PopularSeriesScreen extends StatelessWidget {
  const PopularSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularSeriesCubit,
        PopularSeriesState<TopRatedSeriesModel>>(builder: (context, state) {
      if (state is PopularSeriesStateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Popular Series',
              style: TextStyles.font18WhiteBold,
            ),
            TextButton(
                onPressed: () {
                  context.pushNamed(Routes.popularSeriesGridVeiw);
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
                          .read<PopularSeriesCubit>()
                          .popularSeriesList!
                          .results![index]
                          .id!;

                      context.pushNamed(Routes.seriesDetails,
                          arguments: context
                              .read<PopularSeriesCubit>()
                              .popularSeriesList!
                              .results![index]
                              .id!);
                    },
                    child: SizedBox(
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(15),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${context.read<PopularSeriesCubit>().popularSeriesList!.results![index].posterPath}'),
                            ),
                            Positioned(
                              top: 0,
                              right: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "⭐${context.read<PopularSeriesCubit>().popularSeriesList!.results![index].voteAverage!.toStringAsFixed(2)}",
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
                    .read<PopularSeriesCubit>()
                    .popularSeriesList!
                    .results!
                    .length),
          ),
        ],
      );
    });
  }
}
