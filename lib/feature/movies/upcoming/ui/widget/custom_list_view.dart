import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/class/page_cubit/page_state.dart';
import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/core/theming/colors.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/data/model/upcoming_model.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_cubit.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/class/page_cubit/page_cubit.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';

class CustomUpcomingListView extends StatelessWidget {
  const CustomUpcomingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.maindark,
      body: BlocBuilder<UpcomingCubit, UpcomingState<UpComingModel>>(
        builder: (BuildContext context, UpcomingState<UpComingModel> state) {
          return state.when(initial: () {
            return const Center(child: CircularProgressIndicator());
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, success: (UpComingModel upComingModel) {
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
                              .read<UpcomingCubit>()
                              .upComingList!
                              .results!
                              .length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                ApiConstance.movieId =
                                    upComingModel.results![index].id!;

                                context.pushNamed(Routes.movieDetails,
                                    arguments:
                                        upComingModel.results![index].id!);
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
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: CachedNetworkImage(
                                                    height: 230,
                                                    width: 200,
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${upComingModel.results![index].posterPath}'),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Text(
                                                  '⭐ ${context.read<UpcomingCubit>().upComingList!.results![index].voteAverage!.toStringAsFixed(2)}',
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
                                                .read<UpcomingCubit>()
                                                .upComingList!
                                                .results![index]
                                                .originalTitle!,
                                            style:
                                                TextStyles.font12WhiteSemiBold,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                            upComingModel.page == 1
                                ? Container(
                                    width: 45,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      context
                                          .read<PageCubit>()
                                          .decrementUpcomingPage(context);
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                    ),
                                  ),
                            Text(
                              'Page ${upComingModel.page}',
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<PageCubit>()
                                    .incrementUpcomingPage(context);
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
                        context.read<UpcomingCubit>().getUpcomingMovies();
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
