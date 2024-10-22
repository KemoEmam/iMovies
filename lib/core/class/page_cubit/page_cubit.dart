import 'package:clean_architecture_app/core/class/page_cubit/page_state.dart';
import 'package:clean_architecture_app/feature/Tv/airing_today/logic/airing_today_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/popular_series/logic/popular_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/logic/top_rated_series_cubit.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_cubit.dart';
import 'package:clean_architecture_app/feature/movies/top_rated/logic/top_rated_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../feature/movies/upcoming/logic/upcoming_cubit.dart';

class PageCubit extends Cubit<PgaeState> {
  PageCubit() : super(PageInitial());

  void incrementPopularPage(BuildContext context) {
    context.read<PopularCubit>().page++;
    emit(PageSuccess());
  }

  void decrementPopularPage(BuildContext context) {
    context.read<PopularCubit>().page--;
    emit(PageSuccess());
  }

  void incrementUpcomingPage(BuildContext context) {
    context.read<UpcomingCubit>().page++;
    emit(PageSuccess());
  }

  void decrementUpcomingPage(BuildContext context) {
    context.read<UpcomingCubit>().page--;
    emit(PageSuccess());
  }

  void incrementTopRatedPage(BuildContext context) {
    context.read<TopRatedCubit>().page++;
    emit(PageSuccess());
  }

  void decrementTopRatedPage(BuildContext context) {
    context.read<TopRatedCubit>().page--;
    emit(PageSuccess());
  }

  void incrementTopRatedSeriesPage(BuildContext context) {
    context.read<TopRatedSeriesCubit>().page++;
    emit(PageSuccess());
  }

  void decrementTopRatedSeriesPage(BuildContext context) {
    context.read<TopRatedSeriesCubit>().page--;
    emit(PageSuccess());
  }

  void incrementPopularSeriesPage(BuildContext context) {
    context.read<PopularSeriesCubit>().page++;
    emit(PageSuccess());
  }

  void decrementPopularSeriesPage(BuildContext context) {
    context.read<PopularSeriesCubit>().page--;
    emit(PageSuccess());
  }

  void incrementAiringTodaySeriesPage(BuildContext context) {
    context.read<AiringTodaySeriesCubit>().page++;
    emit(PageSuccess());
  }

  void decrementAiringTodaySeriesPage(BuildContext context) {
    context.read<AiringTodaySeriesCubit>().page--;
    emit(PageSuccess());
  }
}
