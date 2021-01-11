class RestConstants {
  static const String BASE_URL = 'https://api.themoviedb.org/3/';
  static const String IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  static const String NOW_PLAYING = 'movie/now_playing?api_key=';
  static const String TOP_RATED = "movie/top_rated?api_key=";
  static const String SEARCH = 'search/movie?api_key=';
  static const String ApiKey = 'c0d0079aeb23d94e4a8600551a022a77';
  static const String Language = 'language=en-US&page=';
  static const String adult = '&include_adult=false';
  static const String query = '&query=';
  static const String GET_NOW_PLAYING_URL = '$NOW_PLAYING$ApiKey&$Language';
  static const String GET_TOP_RATED_URL = "$TOP_RATED$ApiKey&$Language";
  static const String GET_SEARCH_URL = '$SEARCH$ApiKey&$Language';
}

