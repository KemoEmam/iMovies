import 'package:clean_architecture_app/feature/movies/upcoming/data/model/upcoming_model.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/data/repo/upcoming_repo.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';

class UpcomingCubit extends Cubit<UpcomingState<UpComingModel>> {
  UpcomingCubit(this.upcomingRepo) : super(const UpcomingState.initial());
  final UpcomingRepo upcomingRepo;

  UpComingModel? upComingList;
  late int page = 1;

  void getUpcomingMovies() async {
    emit(const UpcomingState.loading());
    final data = await upcomingRepo.getPopularMovies(queries: {
      'api_key': ApiConstance.apiKey,
      'page': page,
    });
    data.when(success: (UpComingModel upComingModel) {
      upComingList = upComingModel;
      emit(UpcomingState.success(upComingModel));
    }, failure: (error) {
      print(error);
      emit(UpcomingState.error(error: error.apiErrorModel.statusMessage!));
    });
  }
}
