import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/core/helper/spacing.dart';
import 'package:clean_architecture_app/core/theming/style.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/data/model/upcoming_model.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_cubit.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';

class UpComingScreen extends StatelessWidget {
  const UpComingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingCubit, UpcomingState<UpComingModel>>(
      builder: (BuildContext context, UpcomingState<UpComingModel> state) {
        return state.when(initial: () {
          return const Center(child: CircularProgressIndicator());
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }, success: (UpComingModel upComingModel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Upcoming',
                  style: TextStyles.font18WhiteBold,
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.upcomingMovie);
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
                          ApiConstance.movieId =
                              upComingModel.results![index].id!;

                          context.pushNamed(Routes.movieDetails,
                              arguments: upComingModel.results![index].id!);
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
                                          'https://image.tmdb.org/t/p/w500${upComingModel.results![index].posterPath}'),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "⭐${upComingModel.results![index].voteAverage!.toStringAsFixed(2)}",
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
                        .read<UpcomingCubit>()
                        .upComingList!
                        .results!
                        .length),
              ),
            ],
          );
        }, error: (error) {
          return Text(error);
        });
      },
    );
  }
}
