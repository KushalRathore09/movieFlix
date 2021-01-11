import 'package:dio/dio.dart';
import 'package:movieflix/network/client/api_client.dart';
import 'package:movieflix/network/rest_constants.dart';
import 'package:movieflix/ui/home/entity/movie_common.dart';

class TopRatedApiDS {
  Stream<MovieCommon> getTopRatedMovieDataDs(int page, String query) {
    String url = '';
    if (query.isEmpty) {
      url = RestConstants.GET_TOP_RATED_URL + "${page.toString()}";
    } else {
      url = RestConstants.GET_SEARCH_URL +
          "${page.toString()}" +
          RestConstants.query +
          query;
    }
    return ApiClient()
        .dio()
        .get(url, options: Options(headers: {ApiClient.REQUIRES_HEADER: false}))
        .asStream()
        .map((response) => movieCommonFromJson(response.data));
  }
}