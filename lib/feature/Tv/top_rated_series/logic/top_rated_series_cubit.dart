import 'package:clean_architecture_app/feature/Tv/top_rated_series/data/model/top_rated_series_model.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/logic/top_rated_seriesstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import '../data/repo/top_rated_series_repo.dart';

class TopRatedSeriesCubit
    extends Cubit<TopRatedSeriesState<TopRatedSeriesModel>> {
  TopRatedSeriesCubit(this.airingTodayRepo)
      : super(TopRatedSeriesStateInitial());
  final TopRatedSeriesRepo airingTodayRepo;

  TopRatedSeriesModel? topRatedSeriesList;
  late int page = 1;

  void emitTopRatedSeries() async {
    emit(TopRatedSeriesStateLoading());
    final data = await airingTodayRepo.getAiringTodayTv(queries: {
      'api_key': ApiConstance.apiKey,
      'page': page,
    });
    data.when(success: (TopRatedSeriesModel topRatedSeriesModel) {
      topRatedSeriesList = topRatedSeriesModel;
      emit(TopRatedSeriesStateSuccess(topRatedSeriesModel));
    }, failure: (error) {
      print(error);
      emit(TopRatedSeriesStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
