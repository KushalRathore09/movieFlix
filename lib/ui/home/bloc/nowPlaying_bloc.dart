import 'package:movieflix/network/view_state.dart';
import 'package:movieflix/ui/base/base_bloc.dart';
import 'package:movieflix/ui/home/entity/movie_data.dart';
import 'package:movieflix/ui/home/entity/movie_common.dart';
import 'package:movieflix/ui/home/repo/nowPlaying_repo.dart';
import 'package:movieflix/ui/home/states/list_data_state.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingBloc extends BaseBloc {
  NowPlayingRepo _homeRepo = NowPlayingRepo();
  final viewState = PublishSubject<ViewState>();

  final listDataState = BehaviorSubject<ListDataState>();

  final listData = BehaviorSubject<MovieCommon>();
  final movieListData = BehaviorSubject<MovieData>();

  void getData({int page = 1, bool clear = false, String query=''}) {
    subscription.add(_homeRepo
        .getMovieData(page,query)
        .map((data) => ListDataState.completed(data, isLoadingMore: page > 1))
        .onErrorReturnWith(
            (error) => ListDataState.error(error, isLoadingMore: page > 1))
        .startWith(ListDataState.loading(isLoadingMore: page > 1))
        .listen((state) {
      print('////// State: $state');
      listDataState.add(state);
      if (state.isCompleted()) {
        final newList = state.data.movies ?? List();
        final currentList = movieListData.value?.movies ?? List();
        final data = state.data;

        if (state.data.page == 1) {
          if(clear == false){
            currentList.clear();
          }
        }
        currentList.addAll(newList);
  
        var movieData = MovieData(
            page: state.data.page,
            totalPages: state.data.totalPages,
            totalResults: state.data.totalResults,
            movies: currentList);

        listData.add(data);
        movieListData.add(movieData);
      }
    }));
  }

  void loadMore(String query) {
    if(movieListData.value?.totalPages==movieListData.value?.page){
      getData(page: (1), clear: (true), query: (query));
    }
    else{
      getData(page: (listData.value?.page ?? 1) + 1, query: (query));
    }
  }

  @override
  void dispose() {
    super.dispose();
    viewState?.close();
  }
}
