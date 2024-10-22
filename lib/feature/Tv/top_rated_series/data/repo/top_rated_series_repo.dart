import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';
import '../model/top_rated_series_model.dart';

class TopRatedSeriesRepo {
  final ApiServices apiServices;

  TopRatedSeriesRepo({required this.apiServices});
  Future<ApiResult<TopRatedSeriesModel>> getAiringTodayTv({
    required Map<String, dynamic> queries,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: ApiConstance.topRatedTvSeriesUrl, queries: queries);
      return ApiResult.success(TopRatedSeriesModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
