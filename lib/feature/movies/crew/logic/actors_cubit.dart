import 'package:clean_architecture_app/core/class/actors_model.dart';
import 'package:clean_architecture_app/feature/movies/crew/data/repo/actors_repo.dart';
import 'package:clean_architecture_app/feature/movies/crew/logic/actors_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';

class ActorsCubit extends Cubit<ActorsState<ActorsModel>> {
  ActorsCubit(this.actorsRepo) : super(const ActorsState.initial());
  final ActorsRepo actorsRepo;
  ActorsModel? actorList;
  void emitMovieActors({required int movieId}) async {
    emit(const ActorsState.loading());

    final data = await actorsRepo.getActors(queries: {
      'api_key': ApiConstance.apiKey,
    }, id: movieId);

    data.when(success: (ActorsModel movieDetailsModel) {
      actorList = movieDetailsModel;
      emit(ActorsState.success(movieDetailsModel));
    }, failure: (error) {
      print(error);
      emit(ActorsState.error(error: error.apiErrorModel.statusMessage!));
    });
  }
}
