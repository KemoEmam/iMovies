import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';

class PopularRepo {
  final ApiServices apiServices;

  PopularRepo({required this.apiServices});
  Future<ApiResult<MoviesModel>> getPopularMovies({
    required Map<String, dynamic> queries,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: ApiConstance.popularMoviesUrl, queries: queries);
      return ApiResult.success(MoviesModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
