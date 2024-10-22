import 'package:clean_architecture_app/feature/movies/upcoming/data/model/upcoming_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';

class UpcomingRepo {
  final ApiServices apiServices;

  UpcomingRepo({required this.apiServices});
  Future<ApiResult<UpComingModel>> getPopularMovies({
    required Map<String, dynamic> queries,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: ApiConstance.upComingMoviesUrl, queries: queries);
      return ApiResult.success(UpComingModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
