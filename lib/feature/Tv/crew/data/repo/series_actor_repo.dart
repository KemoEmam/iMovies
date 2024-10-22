import 'package:clean_architecture_app/core/class/actors_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';

class SeriesActorRepo {
  final ApiServices apiServices;

  SeriesActorRepo({required this.apiServices});
  Future<ApiResult<ActorsModel>> getSeriesActors({
    required Map<String, dynamic> queries,
    required int id,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: "${ApiConstance.tv}/$id/credits", queries: queries);
      return ApiResult.success(ActorsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
