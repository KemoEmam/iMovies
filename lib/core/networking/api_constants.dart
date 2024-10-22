class ApiConstance {
  //base url
  static const String baseUrl = 'https://api.themoviedb.org/3/';

  //api key
  static const String apiKey = '485dj0138492a1d5e788dc44a5e6c7d9';

  //* movies *
  static const String trendingDayUrl = 'trending/all/day';
  static const String trendingWeekUrl = 'trending/all/week';
  static const String popularMoviesUrl = 'movie/popular';
  static const String nowPlayingMoviesUrl = 'movie/now_playing';
  static const String topRatedMoviesUrl = 'movie/top_rated';
  static const String upComingMoviesUrl = 'movie/upcoming';
  static String moviesUrl = 'movie';

  //* tv series *
  static const String popularTvSeriesUrl = 'tv/popular';
  static const String topRatedTvSeriesUrl = 'tv/top_rated';
  static const String onAirTvSeriesUrl = 'tv/airing_today';
  static String tvSeriesPopularUrl = 'tv/popular';
  static String tv = 'tv/';

  //* search *
  static const String multisearchUrl = 'search/multi';

  static int? movieId;
  static int popularNumPage = 1;
  static int upcomingNumPage = 1;
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
