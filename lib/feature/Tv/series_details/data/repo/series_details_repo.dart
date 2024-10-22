import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';
import '../model/series_details.dart';

class SeriesDetailsRepo {
  final ApiServices apiServices;

  SeriesDetailsRepo({required this.apiServices});
  Future<ApiResult<SeriesDetailsModel>> getSeriesDetails({
    required Map<String, dynamic> queries,
    required int id,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: "${ApiConstance.tv}/$id", queries: queries);
      return ApiResult.success(SeriesDetailsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
