import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:clean_architecture_app/feature/movies/trending/logic/trending_cubit.dart';
import 'package:clean_architecture_app/feature/movies/trending/logic/trending_day_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/colors.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingDayCubit, TrendingDayState<MoviesModel>>(
        builder: (context, state) {
      return state.when(
        initial: () {
          return const Center(child: CircularProgressIndicator());
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        success: (MoviesModel moviesModel) {
          return Container(
            color: ColorManger.maindark,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 700,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 200),
                viewportFraction: 1.4,
                reverse: false,
                initialPage: 0,
              ),
              items: TrendingDayCubit.get(context)
                  .trendingDay!
                  .results!
                  .map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: ColorManger.maindark,
                      ),
                      child: Container(
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 23, 23, 23),
                                const Color.fromARGB(255, 56, 51, 51)
                                    .withOpacity(0.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: const [0.02, 0.3],
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${item.posterPath}',
                            fit: BoxFit.fill,
                          )),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
        error: (error) {
          return Center(child: Text(error));
        },
      );
    });
  }
}
