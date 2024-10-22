import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/class/page_cubit/page_state.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/core/theming/colors.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_cubit.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_state.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/class/page_cubit/page_cubit.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';

class CustomPopularListView extends StatelessWidget {
  const CustomPopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.maindark,
      body: BlocBuilder<PopularCubit, PopularState<MoviesModel>>(
        builder: (BuildContext context, PopularState<MoviesModel> state) {
          return state.when(initial: () {
            return const Center(child: CircularProgressIndicator());
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, success: (MoviesModel moviesModel) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: ColorManger.maindark,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1 / 1.7,
                        children: List.generate(
                          context
                              .read<PopularCubit>()
                              .moviesModel!
                              .results!
                              .length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                ApiConstance.movieId =
                                    moviesModel.results![index].id!;

                                context.pushNamed(Routes.movieDetails,
                                    arguments: moviesModel.results![index].id!);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 280,
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.black54,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color.fromARGB(
                                                          255, 23, 23, 23),
                                                      const Color.fromARGB(
                                                              255, 56, 51, 51)
                                                          .withOpacity(0.0),
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    stops: const [0.02, 0.3],
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                      height: 230,
                                                      width: 200,
                                                      fit: BoxFit.fill,
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${moviesModel.results![index].posterPath}'),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Text(
                                                  '⭐ ${PopularCubit.get(context).moviesModel!.results![index].voteAverage!.toStringAsFixed(2)}',
                                                  style: TextStyles
                                                      .font12WhiteSemiBold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        verticalSpacing(10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            context
                                                .read<PopularCubit>()
                                                .moviesModel!
                                                .results![index]
                                                .originalTitle!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyles.font12WhiteSemiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => PageCubit(),
                    child: BlocConsumer<PageCubit, PgaeState>(
                        builder: (context, state) {
                      return Container(
                        width: 145,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManger.gray,
                        ),
                        child: Row(
                          children: [
                            moviesModel.page == 1
                                ? Container(
                                    width: 45,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      context
                                          .read<PageCubit>()
                                          .decrementPopularPage(context);
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                    ),
                                  ),
                            Text(
                              'Page ${moviesModel.page}',
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<PageCubit>()
                                    .incrementPopularPage(context);
                              },
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      );
                    }, listener: (BuildContext context, state) {
                      if (state is PageSuccess) {
                        context.read<PopularCubit>().fetchTrendingMovies();
                      }
                    }),
                  ),
                  verticalSpacing(20),
                ],
              ),
            );
          }, error: (error) {
            return Text(error);
          });
        },
      ),
    );
  }
}
