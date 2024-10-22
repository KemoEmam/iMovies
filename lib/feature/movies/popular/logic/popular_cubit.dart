import 'package:clean_architecture_app/core/networking/api_constants.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_state.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/popular_repo.dart';

class PopularCubit extends Cubit<PopularState<MoviesModel>> {
  PopularCubit(this.popularRepo) : super(const PopularState.initial());

  static PopularCubit get(context) => BlocProvider.of<PopularCubit>(context);
  final PopularRepo popularRepo;
  MoviesModel? moviesModel;
  late int page = 1;
  Future<void> fetchTrendingMovies() async {
    emit(const PopularState.loading());
    final data = await popularRepo.getPopularMovies(queries: {
      'api_key': ApiConstance.apiKey,
      'page': page,
    });
    data.when(success: (MoviesModel moviesModel) {
      this.moviesModel = moviesModel;
      emit(PopularState.success(moviesModel));
    }, failure: (error) {
      print(error);
      emit(PopularState.error(error: error.apiErrorModel.statusMessage!));
    });
  }
}
