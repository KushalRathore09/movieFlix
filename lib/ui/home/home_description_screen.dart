import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/widgets/skeleton.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../colors.dart';
import 'entity/movie.dart';

class HomeDescriptionScreen extends StatelessWidget {
  final Movie movie;
  final imageUrl;

  const HomeDescriptionScreen({Key key, this.movie, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: new Material(
          color: Colors.transparent,
          child: new CustomScrollView(
            slivers: [
              new SliverAppBar(
                centerTitle: true,
                flexibleSpace: new FlexibleSpaceBar(
                  background: AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: new Container(
                      child: CachedNetworkImage(
                        imageUrl: "http://image.tmdb.org/t/p/w500$imageUrl",
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
                    ),
                  ),
                ),
                pinned: false,
                automaticallyImplyLeading: false,
                leading: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.height / 3.5,
                backgroundColor: colorGrayscale10,
              ),
              SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: true,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: double.infinity,
                  color: colorGrayscale10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${movie.originalTitle}' ?? '',
                        style: TextStyle(
                            fontSize: 34.0,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                      richTextWidget(18.0, 'Release date', movie.releaseDate),
                      richTextWidget(
                          20.0, 'Rating', '${movie.voteAverage.toString()}/10'),
                      ratingBar(),
                      richTextWidget(MediaQuery.of(context).size.height / 2.5,
                          'Overview', movie.overview),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget richTextWidget(double height, String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: height,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 18,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title : ',
                style: TextStyle(
                    fontSize: 14.0, color: Colors.white.withOpacity(0.5)),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                    fontSize: 14.0,
                    height: 1.4,
                    color: colorBlackGradient90.withOpacity(0.6),
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ratingBar() => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SmoothStarRating(
            allowHalfRating: true,
            starCount: 10,
            rating: movie.voteAverage ?? 0.0,
            size: 16.0,
            isReadOnly: true,
            color: colorBlackGradient70,
            borderColor: colorBlackGradient90.withOpacity(0.5),
            spacing: 3.0),
      );
}
