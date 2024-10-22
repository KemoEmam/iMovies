import 'package:clean_architecture_app/feature/movies/video/data/model/video_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';

class VideoRepo {
  final ApiServices apiServices;

  VideoRepo({required this.apiServices});
  Future<ApiResult<VideoModel>> getVideoTrailer({
    required Map<String, dynamic> queries,
    required int movieId,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: '${ApiConstance.moviesUrl}/$movieId/videos', queries: queries);
      return ApiResult.success(VideoModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
