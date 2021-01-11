import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/network/rest_constants.dart';
import 'package:movieflix/ui/home/entity/movie.dart';
import 'package:movieflix/widgets/skeleton.dart';

import '../../../colors.dart';
import '../home_description_screen.dart';

class MovieListViewTile extends StatelessWidget {
  MovieListViewTile(this.movieLists);

  final Movie movieLists;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: new Row(
            children: <Widget>[_DetailedInfo(movieLists)],
          ),
        )
      ],
    );
  }
}

class _DetailedInfo extends StatelessWidget {
  _DetailedInfo(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final isImageBroken =
        movie.backdropPath != "null" ? movie.backdropPath : movie.posterPath;
    return Expanded(
      child: InkWell(
        splashColor: Color(0xFF38383d),
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => HomeDescriptionScreen(
                    movie: movie,
                    imageUrl: isImageBroken,
                  )));
        },
        child: Container(
          child: new Card(
              elevation: 10.0,
              color: colorGrayscale10,
              child: new Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: "${RestConstants.IMAGE_URL}$isImageBroken",
                    placeholder: (context, url) => Skeleton(
                      width: MediaQuery.of(context).size.width,
                      height: 200.0,
                    ),
                    errorWidget: (context, url, error) => Container(
                        color: colorGrayscale10,
                        height: 200.0,
                        child: Center(
                            child: Icon(
                          Icons.error,
                          color: colorMinionYellow,
                          size: 40.0,
                        ))),
                  ),
                  Positioned(
                    bottom: 5.0,
                    left: 10.0,
                    child: Column(
                      children: [
                        Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white.withOpacity(0.9),
                              shadows: [
                                Shadow(
                                  blurRadius: 12.0,
                                  color: colorBlack,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
