import 'package:clean_architecture_app/core/class/actors_model.dart';
import 'package:clean_architecture_app/feature/Tv/crew/data/repo/series_actor_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import 'actor_series_state.dart';

class SeriesActorCubit extends Cubit<SeriesActorState<ActorsModel>> {
  SeriesActorCubit(this.seriesActorRepo) : super(SeriesActorStateInitial());
  final SeriesActorRepo seriesActorRepo;
  ActorsModel? actorList;
  void emitSeriesActors({required int seriesId}) async {
    emit(SeriesActorStateLoading());

    final data = await seriesActorRepo.getSeriesActors(queries: {
      'api_key': ApiConstance.apiKey,
    }, id: seriesId);

    data.when(success: (ActorsModel actorModel) {
      actorList = actorModel;
      emit(SeriesActorStateSuccess(actorModel));
    }, failure: (error) {
      print(error);
      emit(SeriesActorStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
