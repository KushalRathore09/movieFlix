import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/network/app_exception.dart';
import 'package:movieflix/ui/base/base_stateful_widget.dart';
import 'package:movieflix/ui/home/bloc/topRated_bloc.dart';
import 'package:movieflix/ui/home/entity/movie.dart';
import 'package:movieflix/ui/home/entity/movie_data.dart';
import 'package:movieflix/ui/home/states/list_data_state.dart';
import 'package:movieflix/ui/home/tiles/movie_list_tile.dart';
import 'package:movieflix/widgets/custom_loader.dart';
import 'package:movieflix/widgets/error_view.dart';
import 'package:movieflix/widgets/pagination_wrapper.dart';

class TopRatedScreen extends StatefulWidget{
  String searchText = '';
  TopRatedScreen(this.searchText);

  @override
  State<StatefulWidget> createState()=> TopRatedScreenState(searchText);

}

class TopRatedScreenState extends BaseStatefulWidgetState<TopRatedScreen>{
  String searchText = '';
  TopRatedScreenState(this.searchText);
  final _topRatedBloc = TopRatedBloc();

  @override
  void initState(){
    super.initState() ;
    _topRatedBloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ListDataState>(
            stream: _topRatedBloc.listDataState,
            builder: (context, snapshot) {
              final state = snapshot.data;
              final isLoadingMore = state?.isLoadingMore ?? false;

              if ((state?.isLoading() ?? true) && !isLoadingMore) {
                return CustomLoader();
              }

              if (state.isError()) {
                return Center(
                  child: ErrorView(
                    content: state.error?.toString(),
                    retryVisible: (state.error is NoInternetException),
                    onPressed: () {
                      _topRatedBloc.getData();
                    },
                  ),
                );
              }

              return StreamBuilder<MovieData>(
                  stream: _topRatedBloc.movieListData,
                  initialData: _topRatedBloc.movieListData.value,
                  builder: (context, snapshot) {
                    final items = snapshot.data?.movies ?? List();

                    if (state.isCompleted() &&
                        items.isEmpty &&
                        !state.isLoadingMore)
                      return Center(
                        child: ErrorView(
                          content: state.error?.toString(),
                          retryVisible: false,
                        ),
                      );

                    return PaginationWrapper(
                      onLoadMore: () {
                        _topRatedBloc.loadMore(searchText);
                      },
                      isLoading: state.isLoading(),
                      isEndReached: false,
                      scrollableChild: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              _movieList(items),
                            ],
                          )),
                    );
                  });
            })
    );
  }

  Widget _movieList(List<Movie> movieList) {
    return Container(
      height: MediaQuery.of(context).size.height - 90,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          if (position == movieList.length) {
            return CustomLoader();
          }
          Movie movie = movieList[position];
          return MovieListViewTile(movie);
        },
        itemCount: movieList.length + 1,
      ),
    );
  }

}