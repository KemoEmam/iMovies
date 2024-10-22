import 'package:clean_architecture_app/feature/Tv/airing_today/data/repo/airing_today_repo.dart';
import 'package:clean_architecture_app/feature/Tv/airing_today/logic/airing_today_series_state.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/data/model/top_rated_series_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';

class AiringTodaySeriesCubit
    extends Cubit<AiringTodaySeriesState<TopRatedSeriesModel>> {
  AiringTodaySeriesCubit(this.airingTodaySeriesRepo)
      : super(AiringTodaySeriesStateInitial());
  final AiringTodaySeriesRepo airingTodaySeriesRepo;

  TopRatedSeriesModel? airingTodayList;
  late int page = 1;

  void emiAiringTodaySeries() async {
    emit(AiringTodaySeriesStateLoading());
    final data = await airingTodaySeriesRepo.getAiringTodaySeriesTv(queries: {
      'api_key': ApiConstance.apiKey,
      'page': page,
    });
    data.when(success: (TopRatedSeriesModel topRatedSeriesModel) {
      airingTodayList = topRatedSeriesModel;
      emit(AiringTodaySeriesStateSuccess(topRatedSeriesModel));
    }, failure: (error) {
      print(error);
      emit(AiringTodaySeriesStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
