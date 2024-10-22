import 'package:clean_architecture_app/core/networking/api_constants.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/model/trending_model.dart';
import 'package:clean_architecture_app/feature/movies/trending/logic/trending_day_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/trending_repo.dart';

class TrendingDayCubit extends Cubit<TrendingDayState<MoviesModel>> {
  TrendingDayCubit(this.trendingRepo) : super(const TrendingDayState.initial());
  static TrendingDayCubit get(context) => BlocProvider.of(context);
  final TrendingRepo trendingRepo;
  MoviesModel? trendingDay;
  MoviesModel? trendingWeek;
  int val = 1;

  Future<void> getTrendingDay() async {
    emit(const TrendingDayState.loading());
    final data = await trendingRepo.trendingDay(queries: {
      'api_key': ApiConstance.apiKey,
    });
    data.when(success: (MoviesModel moviesModel) {
      trendingDay = moviesModel;
      emit(TrendingDayState.success(moviesModel));
    }, failure: (error) {
      print(error);
      emit(TrendingDayState.error(error: error.apiErrorModel.statusMessage!));
    });
  }

  Future<void> getTrendingWeek() async {
    emit(const TrendingDayState.loading());
    final data = await trendingRepo.trendingWeek(queries: {
      'api_key': ApiConstance.apiKey,
    });
    data.when(success: (MoviesModel moviesModel) {
      trendingDay = moviesModel;
      emit(TrendingDayState.success(moviesModel));
    }, failure: (error) {
      print(error);
      emit(TrendingDayState.error(error: error.apiErrorModel.statusMessage!));
    });
  }

  void changeTrendState(int value) {
    val = value;
    if (val == 1) {
      getTrendingDay();
      trendingDay!.results!.clear();
      val = int.parse(value.toString());
      emit(state);
    } else if (val == 2) {
      getTrendingWeek();
      trendingDay!.results!.clear();
      val = int.parse(value.toString());
      emit(state);
    }
  }
}
