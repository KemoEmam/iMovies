import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_services.dart';
import '../model/search_model.dart';

class SearchRepo {
  final ApiServices apiServices;

  SearchRepo({required this.apiServices});
  Future<ApiResult<SearchModel>> getActors({
    required Map<String, dynamic> queries,
  }) async {
    try {
      var response = await apiServices.getData(
          urll: ApiConstance.multisearchUrl, queries: queries);
      return ApiResult.success(SearchModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
