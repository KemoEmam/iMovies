import 'package:clean_architecture_app/core/routing/routes.dart';
import 'package:clean_architecture_app/feature/Tv/airing_today/logic/airing_today_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/popular_series/logic/popular_series_cubit.dart';
import 'package:clean_architecture_app/feature/Tv/top_rated_series/logic/top_rated_series_cubit.dart';
import 'package:clean_architecture_app/feature/auth/login/ui/screen/login_screen.dart';
import 'package:clean_architecture_app/feature/movies/popular/logic/popular_cubit.dart';
import 'package:clean_architecture_app/feature/movies/popular/ui/widget/custom_popular_list_view.dart';
import 'package:clean_architecture_app/feature/movies/top_rated/logic/top_rated_cubit.dart';
import 'package:clean_architecture_app/feature/movies/upcoming/logic/upcoming_cubit.dart';
import 'package:clean_architecture_app/feature/search/logic/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/Tv/airing_today/ui/widget/airing_today_grid_view.dart';
import '../../feature/Tv/popular_series/ui/widget/popular_grid_view.dart';
import '../../feature/Tv/series_details/ui/series_details_screen.dart';
import '../../feature/Tv/top_rated_series/ui/widget/top_rated_grid_veiw.dart';
import '../../feature/auth/sign_up/ui/screen/sign_up_screen.dart';
import '../../feature/home/ui/home_screen.dart';
import '../../feature/movies/movie_details/ui/screen/movie_details_screen.dart';
import '../../feature/movies/now_playing_videos/logic/now_playing_videos_cubit.dart';
import '../../feature/movies/top_rated/ui/widget/top_rated_list_view.dart';
import '../../feature/movies/trending/logic/trending_cubit.dart';
import '../../feature/movies/trending/ui/screen/trending_screen.dart';
import '../../feature/movies/upcoming/ui/widget/custom_list_view.dart';
import '../../feature/search/ui/screen/search_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => getIt<TrendingDayCubit>()
                ..getTrendingDay()
                ..getTrendingWeek(),
            ),
            BlocProvider(
                create: (context) =>
                    getIt<PopularCubit>()..fetchTrendingMovies()),
            BlocProvider(
                create: (context) =>
                    getIt<UpcomingCubit>()..getUpcomingMovies()),
            BlocProvider(
                create: (context) =>
                    getIt<NowPlayingVideosCubit>()..getNowPlayingVideos()),
            BlocProvider(
              create: (context) => getIt<TopRatedCubit>()..getTopRatedMovies(),
            ),
            BlocProvider(
              create: (context) =>
                  getIt<TopRatedSeriesCubit>()..emitTopRatedSeries(),
            ),
            BlocProvider(
              create: (context) =>
                  getIt<PopularSeriesCubit>()..emitPopularSeries(),
            ),
            BlocProvider(
              create: (context) =>
                  getIt<AiringTodaySeriesCubit>()..emiAiringTodaySeries(),
            ),
            BlocProvider(
              create: (context) => getIt<SearchCubit>(),
            ),
          ], child: const HomeScreen()),
        );
      // *movies screens *
      case Routes.trending:
        return MaterialPageRoute(
          builder: (_) => const TrendingScreen(),
        );

      case Routes.movieDetails:
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
            movieId: int.parse(argument.toString()),
          ),
        );
      case Routes.upcomingMovie:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => getIt<UpcomingCubit>()..getUpcomingMovies(),
              child: const CustomUpcomingListView()),
        );
      case Routes.popularScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => getIt<PopularCubit>()..fetchTrendingMovies(),
              child: const CustomPopularListView()),
        );
      case Routes.topRated:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => getIt<TopRatedCubit>()..getTopRatedMovies(),
              child: const CustomTopRatedListView()),
        );

      // *Tv screens *
      case Routes.topRatedSeriesGridVeiw:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<TopRatedSeriesCubit>()..emitTopRatedSeries(),
              child: const CustomTopRatedGridView()),
        );
      case Routes.popularSeriesGridVeiw:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<PopularSeriesCubit>()..emitPopularSeries(),
              child: const CustomPopularGridView()),
        );
      case Routes.airingTodaySeriesGridVeiw:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<AiringTodaySeriesCubit>()..emiAiringTodaySeries(),
              child: const CustomAiringTodayGridView()),
        );
      case Routes.seriesDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<AiringTodaySeriesCubit>()..emiAiringTodaySeries(),
              child:
                  SeriesDetailsScreen(movieId: int.parse(argument.toString()))),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => getIt<SearchCubit>(),
              child: const SearchScreen()),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
