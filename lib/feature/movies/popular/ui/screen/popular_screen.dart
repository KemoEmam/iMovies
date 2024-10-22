import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/core/helper/spacing.dart';
import 'package:clean_architecture_app/core/networking/api_constants.dart';
import 'package:clean_architecture_app/core/routing/routes.dart';
import 'package:clean_architecture_app/core/theming/style.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_cubit.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_state.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState<MoviesModel>>(
      builder: (BuildContext context, PopularState<MoviesModel> state) {
        return state.when(initial: () {
          return const Center(child: CircularProgressIndicator());
        }, loading: () {
          return const SizedBox();
        }, success: (MoviesModel moviesModel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Popular',
                  style: TextStyles.font18WhiteBold,
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.popularScreen);
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
                              moviesModel.results![index].id!;

                          context.pushNamed(Routes.movieDetails,
                              arguments: moviesModel.results![index].id!);
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
                                          'https://image.tmdb.org/t/p/w500${moviesModel.results![index].posterPath}'),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " ⭐ ${PopularCubit.get(context).moviesModel!.results![index].voteAverage!.toStringAsFixed(2)}",
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
                    itemCount:
                        PopularCubit.get(context).moviesModel!.results!.length),
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
