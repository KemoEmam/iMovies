import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import '../data/model/movie_details_model.dart';
import '../data/repo/movie_details_repo.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState<MovieDetailsModel>> {
  MovieDetailsCubit(this.movieDetailsRepo)
      : super(const MovieDetailsState.initial());
  final MovieDetailsRepo movieDetailsRepo;
  MovieDetailsModel? movieDetailsList;

  void getMovieDetails({required int movieId}) async {
    emit(const MovieDetailsState.loading());

    final data = await movieDetailsRepo.getMoviesDetails(queries: {
      'api_key': ApiConstance.apiKey,
    }, id: movieId);

    data.when(success: (MovieDetailsModel movieDetailsModel) {
      movieDetailsList = movieDetailsModel;
      emit(MovieDetailsState.success(movieDetailsModel));
    }, failure: (error) {
      print(error);
      emit(MovieDetailsState.error(error: error.apiErrorModel.statusMessage!));
    });
  }
}
