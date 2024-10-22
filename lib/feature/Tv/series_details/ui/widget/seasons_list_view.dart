import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/spacing.dart';
import '../../logic/series_details_cubit.dart';

class SeasonsListView extends StatelessWidget {
  const SeasonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(15),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: context
                                  .read<SeriesDetailsCubit>()
                                  .seriesDetailsList!
                                  .seasons![index]
                                  .posterPath !=
                              null
                          ? CachedNetworkImage(
                              height: 230,
                              width: 200,
                              fit: BoxFit.fill,
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${context.read<SeriesDetailsCubit>().seriesDetailsList!.seasons![index].posterPath}')
                          : CachedNetworkImage(
                              height: 230,
                              width: 200,
                              fit: BoxFit.fill,
                              imageUrl:
                                  'https://ih0.redbubble.net/image.425660345.5511/raf,360x360,075,t,fafafa:ca443f4786.jpg',
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return horizentalSpacing(20);
          },
          itemCount: context
              .read<SeriesDetailsCubit>()
              .seriesDetailsList!
              .seasons!
              .length),
    );
  }
}
