import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/class/actors_model.dart';
import 'package:clean_architecture_app/feature/movies/crew/logic/actors_cubit.dart';
import 'package:clean_architecture_app/feature/movies/crew/logic/actors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';

class ActorScreen extends StatelessWidget {
  const ActorScreen({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<ActorsCubit>()..emitMovieActors(movieId: movieId),
      child: BlocBuilder<ActorsCubit, ActorsState<ActorsModel>>(
        builder: (BuildContext context, ActorsState<ActorsModel> state) {
          return state.when(initial: () {
            return const SizedBox();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, success: (ActorsModel actorsModel) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        imageUrl: actorsModel.cast![index].profilePath == null
                            ? "https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png"
                            : 'https://image.tmdb.org/t/p/w500${actorsModel.cast![index].profilePath}'),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 20,
                  );
                },
                itemCount: actorsModel.cast!.length > 10
                    ? 10
                    : actorsModel.cast!.length,
              ),
            );
          }, error: (error) {
            return Center(child: Text(error));
          });
        },
      ),
    );
  }
}
