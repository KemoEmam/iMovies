import 'package:clean_architecture_app/feature/Tv/popular_series/logic/popular_series_state.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/data/model/top_rated_series_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import '../data/repo/popular_series_repo.dart';

class PopularSeriesCubit
    extends Cubit<PopularSeriesState<TopRatedSeriesModel>> {
  PopularSeriesCubit(this.popularSeriesRepo)
      : super(PopularSeriesStateInitial());
  final PopularSeriesRepo popularSeriesRepo;

  TopRatedSeriesModel? popularSeriesList;
  late int page = 1;

  void emitPopularSeries() async {
    emit(PopularSeriesStateLoading());
    final data = await popularSeriesRepo.getPopularSeriesTv(queries: {
      'api_key': ApiConstance.apiKey,
      'page': page,
    });
    data.when(success: (TopRatedSeriesModel topRatedSeriesModel) {
      popularSeriesList = topRatedSeriesModel;
      emit(PopularSeriesStateSuccess(topRatedSeriesModel));
    }, failure: (error) {
      print(error);
      emit(PopularSeriesStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
