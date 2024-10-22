import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/data/model/top_rated_series_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';
import '../../logic/top_rated_series_cubit.dart';
import '../../logic/top_rated_seriesstate.dart';

class TopRatedSeriesScreen extends StatelessWidget {
  const TopRatedSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController =
        ScrollController(initialScrollOffset: 160.0); // Adjusted initial offset

    return BlocBuilder<TopRatedSeriesCubit,
        TopRatedSeriesState<TopRatedSeriesModel>>(builder: (context, state) {
      if (state is TopRatedSeriesStateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Now',
                    style: TextStyles.font18WhiteBold,
                  ),
                  TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.topRatedSeriesGridVeiw);
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.amber),
                      ))
                ]),
          ),
          verticalSpacing(20),
          SizedBox(
            height: 280,
            child: RotatedBox(
              quarterTurns: 3, // Rotate the ListWheelScrollView 270 degrees
              child: ListWheelScrollView.useDelegate(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemExtent: 160, // Adjust the item extent to fit your design
                onSelectedItemChanged: (index) {
                  scrollController
                      .jumpTo((index + 1) * 160.0); // 160.0 is the itemExtent
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final result = context
                        .read<TopRatedSeriesCubit>()
                        .topRatedSeriesList!
                        .results![index];
                    return RotatedBox(
                      quarterTurns: 1,
                      child: GestureDetector(
                        onTap: () {
                          ApiConstance.movieId = context
                              .read<TopRatedSeriesCubit>()
                              .topRatedSeriesList!
                              .results![index]
                              .id!;

                          context.pushNamed(Routes.seriesDetails,
                              arguments: context
                                  .read<TopRatedSeriesCubit>()
                                  .topRatedSeriesList!
                                  .results![index]
                                  .id!);
                        },
                        child: SizedBox(
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  height: 280,
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${result.posterPath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "⭐${result.voteAverage!.toStringAsFixed(2)}",
                                      style: TextStyles.font12WhiteBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: context
                      .read<TopRatedSeriesCubit>()
                      .topRatedSeriesList!
                      .results!
                      .length,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
