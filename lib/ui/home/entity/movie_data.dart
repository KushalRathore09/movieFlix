

import 'movie.dart';

class MovieData {
  List<Movie> movies;
  int page;
  int totalResults;
  int totalPages;

  MovieData({
    this.movies,
    this.page,
    this.totalResults,
    this.totalPages,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
      movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      page: json["page"],
      totalResults: json["total_results"],
      totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    "page": page,
    "total_results": totalResults,
    "total_pages": totalPages,
  };
}