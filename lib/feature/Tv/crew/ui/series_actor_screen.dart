import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/class/actors_model.dart';
import 'package:clean_architecture_app/feature/Tv/crew/logic/actor_series_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../logic/actor_series_cubit.dart';

class SeriesActorScreen extends StatelessWidget {
  const SeriesActorScreen({super.key, required this.seriesId});
  final int seriesId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<SeriesActorCubit>()..emitSeriesActors(seriesId: seriesId),
      child: BlocBuilder<SeriesActorCubit, SeriesActorState<ActorsModel>>(
        builder: (BuildContext context, SeriesActorState<ActorsModel> state) {
          if (state is SeriesActorStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                      imageUrl: context
                                  .read<SeriesActorCubit>()
                                  .actorList!
                                  .cast![index]
                                  .profilePath ==
                              null
                          ? "https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png"
                          : 'https://image.tmdb.org/t/p/w500${context.read<SeriesActorCubit>().actorList!.cast![index].profilePath}'),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemCount:
                  context.read<SeriesActorCubit>().actorList!.cast!.length > 10
                      ? 10
                      : context
                          .read<SeriesActorCubit>()
                          .actorList!
                          .cast!
                          .length,
            ),
          );
        },
      ),
    );
  }
}
