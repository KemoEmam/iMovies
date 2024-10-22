import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';
import '../../../top_rated_series/data/model/top_rated_series_model.dart';

class PopularSeriesRepo {
  final ApiServices apiServices;

  PopularSeriesRepo({required this.apiServices});
  Future<ApiResult<TopRatedSeriesModel>> getPopularSeriesTv({
    required Map<String, dynamic> queries,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: ApiConstance.popularTvSeriesUrl, queries: queries);
      return ApiResult.success(TopRatedSeriesModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
