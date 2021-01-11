

import 'package:movieflix/ui/base/base_ui_state.dart';
import 'package:movieflix/ui/home/entity/movie_common.dart';

class ListDataState extends BaseUiState<MovieCommon> {
  var isLoadingMore = false;

  ListDataState();

  /// Loading state
  ListDataState.loading({this.isLoadingMore}) : super.loading();

  /// Completed state
  ListDataState.completed(MovieCommon movie,{this.isLoadingMore}) : super.completed(data: movie);

  /// Error state
  ListDataState.error(dynamic exception,{this.isLoadingMore}) : super.error(exception);
}
