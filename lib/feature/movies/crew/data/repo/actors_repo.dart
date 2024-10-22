import 'package:clean_architecture_app/core/class/actors_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';

class ActorsRepo {
  final ApiServices apiServices;

  ActorsRepo({required this.apiServices});
  Future<ApiResult<ActorsModel>> getActors({
    required Map<String, dynamic> queries,
    required int id,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: "${ApiConstance.moviesUrl}/$id/credits", queries: queries);
      return ApiResult.success(ActorsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
