

import 'package:movieflix/ui/home/ds/nowPlaying_api_ds.dart';
import 'package:movieflix/ui/home/entity/movie_common.dart';

class NowPlayingRepo {
  final _homeApiDS = NowPlayingApiDS();

  Stream<MovieCommon> getMovieData(int page, String query) {
    return _homeApiDS.getNowPlayingMovieDataDs(page,query);
  }
}
