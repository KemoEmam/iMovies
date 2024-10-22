import 'package:clean_architecture_app/core/networking/api_services.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../model/movie_details_model.dart';

class MovieDetailsRepo {
  final ApiServices apiServices;

  MovieDetailsRepo({required this.apiServices});

  Future<ApiResult<MovieDetailsModel>> getMoviesDetails({
    required Map<String, dynamic> queries,
    required int id,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: "${ApiConstance.moviesUrl}/$id", queries: queries);
      return ApiResult.success(MovieDetailsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
