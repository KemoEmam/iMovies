import 'package:clean_architecture_app/feature/movies/top_rated/data/repo/top_reted_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import '../../trending/data/model/trending_model.dart';
import 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState<MoviesModel>> {
  TopRatedCubit(this.topRatedRepo) : super(TopRatedStateInitial());
  final TopRatedRepo topRatedRepo;
  MoviesModel? moviesModelList;
  late int page = 1;

  Future<void> getTopRatedMovies() async {
    emit(TopRatedStateLoading());
    final data = await topRatedRepo.fetchTopRatedMovies(queries: {
      'api_key': ApiConstance.apiKey,
      'page': page,
    });
    data.when(success: (MoviesModel moviesModel) {
      moviesModelList = moviesModel;
      emit(TopRatedStateSuccess(moviesModel));
    }, failure: (error) {
      print(error);
      emit(TopRatedStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
