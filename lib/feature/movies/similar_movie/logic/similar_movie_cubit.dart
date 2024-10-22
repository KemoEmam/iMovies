import 'package:clean_architecture_app/feature/movies/similar_movie/data/repo/similar_movie_repo.dart';
import 'package:clean_architecture_app/feature/movies/similar_movie/logic/similar_movie_state.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';

class SimilarMovieCubit extends Cubit<SimmilarMovieState<MoviesModel>> {
  SimilarMovieCubit(this.similarMovieRepo)
      : super(const SimmilarMovieState.initial());
  final SimilarMovieRepo similarMovieRepo;

  void getSimilarMovies({required int movieId}) async {
    emit(const SimmilarMovieState.loading());
    final data = await similarMovieRepo.fetchSimilarMovies(queries: {
      'api_key': ApiConstance.apiKey,
    }, movieId: movieId);
    data.when(success: (MoviesModel moviesModel) {
      emit(SimmilarMovieState.success(moviesModel));
    }, failure: (error) {
      emit(SimmilarMovieState.error(error: error.apiErrorModel.statusMessage!));
    });
  }
}
