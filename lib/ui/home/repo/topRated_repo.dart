import 'package:movieflix/ui/home/ds/topRated_api_ds.dart';
import 'package:movieflix/ui/home/entity/movie_common.dart';

class TopRatedRepo {
  final _homeApiDS = TopRatedApiDS();

  Stream<MovieCommon> getMovieData(int page, String query) {
    return _homeApiDS.getTopRatedMovieDataDs(page,query);
  }
}