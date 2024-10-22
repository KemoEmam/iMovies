import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';
import '../model/series_video_model.dart';

class SeriesVideoRepo {
  final ApiServices apiServices;

  SeriesVideoRepo({required this.apiServices});
  Future<ApiResult<SeriesVideoModel>> getSeriesVideoTrailer({
    required Map<String, dynamic> queries,
    required int seriesId,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: '${ApiConstance.tv}/$seriesId/videos', queries: queries);
      return ApiResult.success(SeriesVideoModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
