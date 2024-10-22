import 'package:clean_architecture_app/feature/Tv/airing_today/data/repo/airing_today_repo.dart';
import 'package:clean_architecture_app/feature/Tv/airing_today/logic/airing_today_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/crew/data/repo/series_actor_repo.dart';
import 'package:clean_architecture_app/feature/Tv/crew/logic/actor_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/popular_series/data/repo/popular_series_repo.dart';
import 'package:clean_architecture_app/feature/Tv/popular_series/logic/popular_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/series_details/data/repo/series_details_repo.dart';
import 'package:clean_architecture_app/feature/Tv/series_details/logic/series_details_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/data/repo/top_rated_series_repo.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/logic/top_rated_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/video/data/repo/series_video_repo.dart';
import 'package:clean_architecture_app/feature/Tv/video/logic/series_video_cubit.dart';
import 'package:clean_architecture_app/feature/movies/crew/data/repo/actors_repo.dart';
import 'package:clean_architecture_app/feature/movies/crew/logic/actors_cubit.dart';
import 'package:clean_architecture_app/feature/movies/now_playing_videos/data/repo/now_pllaying_videos_repo.dart';
import 'package:clean_architecture_app/feature/movies/now_playing_videos/logic/now_playing_videos_cubit.dart';
import 'package:clean_architecture_app/feature/movies/popular/data/repo/popular_repo.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_cubit.dart';
import 'package:clean_architecture_app/feature/movies/similar_movie/data/repo/similar_movie_repo.dart';
import 'package:clean_architecture_app/feature/movies/similar_movie/logic/similar_movie_cubit.dart';
import 'package:clean_architecture_app/feature/movies/top_rated/data/repo/top_reted_repo.dart';
import 'package:clean_architecture_app/feature/movies/top_rated/logic/top_rated_cubit.dart';
import 'package:clean_architecture_app/feature/movies/trending/data/repo/trending_repo.dart';
import 'package:clean_architecture_app/feature/movies/trending/logic/trending_cubit.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/data/repo/upcoming_repo.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_cubit.dart';
import 'package:clean_architecture_app/feature/movies/video/data/repo/video_repo.dart';
import 'package:clean_architecture_app/feature/movies/video/logic/video_cubit.dart';
import 'package:clean_architecture_app/feature/search/data/repo/search_repo.dart';
import 'package:clean_architecture_app/feature/search/logic/search_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/movies/movie_details/data/repo/movie_details_repo.dart';
import '../../feature/movies/movie_details/logic/movie_details_cubit.dart';
import '../class/page_cubit/page_cubit.dart';
import '../networking/api_factory.dart';
import '../networking/api_services.dart';

final getIt = GetIt.instance;
Future<void> setupGetit() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio: dio));
  getIt.registerLazySingleton<TrendingRepo>(
      () => TrendingRepo(apiServices: getIt()));
  getIt.registerFactory<TrendingDayCubit>(() => TrendingDayCubit(getIt()));

  getIt.registerLazySingleton<PopularRepo>(
      () => PopularRepo(apiServices: getIt()));
  getIt.registerFactory<PopularCubit>(() => PopularCubit(getIt()));

  getIt.registerLazySingleton<MovieDetailsRepo>(
      () => MovieDetailsRepo(apiServices: getIt()));
  getIt.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(getIt()));

  getIt.registerLazySingleton<UpcomingRepo>(
      () => UpcomingRepo(apiServices: getIt()));
  getIt.registerFactory<UpcomingCubit>(() => UpcomingCubit(getIt()));
  getIt.registerFactory<PageCubit>(() => PageCubit());

  getIt.registerLazySingleton<ActorsRepo>(
      () => ActorsRepo(apiServices: getIt()));
  getIt.registerFactory<ActorsCubit>(() => ActorsCubit(getIt()));

  getIt.registerLazySingleton<VideoRepo>(() => VideoRepo(apiServices: getIt()));
  getIt.registerFactory<VideoCubit>(() => VideoCubit(getIt()));

  getIt.registerLazySingleton<SimilarMovieRepo>(
      () => SimilarMovieRepo(apiServices: getIt()));
  getIt.registerFactory<SimilarMovieCubit>(() => SimilarMovieCubit(getIt()));

  getIt.registerLazySingleton<NowPLayingVideosRepo>(
      () => NowPLayingVideosRepo(apiServices: getIt()));
  getIt.registerFactory<NowPlayingVideosCubit>(
      () => NowPlayingVideosCubit(getIt()));

  getIt.registerLazySingleton<TopRatedRepo>(
      () => TopRatedRepo(apiServices: getIt()));
  getIt.registerFactory<TopRatedCubit>(() => TopRatedCubit(getIt()));

  getIt.registerLazySingleton<TopRatedSeriesRepo>(
      () => TopRatedSeriesRepo(apiServices: getIt()));
  getIt
      .registerFactory<TopRatedSeriesCubit>(() => TopRatedSeriesCubit(getIt()));

  getIt.registerLazySingleton<PopularSeriesRepo>(
      () => PopularSeriesRepo(apiServices: getIt()));
  getIt.registerFactory<PopularSeriesCubit>(() => PopularSeriesCubit(getIt()));

  getIt.registerLazySingleton<AiringTodaySeriesRepo>(
      () => AiringTodaySeriesRepo(apiServices: getIt()));
  getIt.registerFactory<AiringTodaySeriesCubit>(
      () => AiringTodaySeriesCubit(getIt()));

  getIt.registerLazySingleton<SeriesDetailsRepo>(
      () => SeriesDetailsRepo(apiServices: getIt()));
  getIt.registerFactory<SeriesDetailsCubit>(() => SeriesDetailsCubit(getIt()));

  getIt.registerLazySingleton<SeriesVideoRepo>(
      () => SeriesVideoRepo(apiServices: getIt()));
  getIt.registerFactory<SeriesVideoCubit>(() => SeriesVideoCubit(getIt()));

  getIt.registerLazySingleton<SeriesActorRepo>(
      () => SeriesActorRepo(apiServices: getIt()));
  getIt.registerFactory<SeriesActorCubit>(() => SeriesActorCubit(getIt()));

  getIt.registerLazySingleton<SearchRepo>(
      () => SearchRepo(apiServices: getIt()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
}
