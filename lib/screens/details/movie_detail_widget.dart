import 'package:flutter/material.dart';
import 'package:tm_demo/api/endpoints.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/details/base_details_state.dart';
import 'package:tm_demo/screens/details/scrolling_artists_widget.dart';
import 'package:tm_demo/utils/size_utils.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends BaseDetailsState<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return getDetailsWidget(
        widget.movie.title,
        widget.movie.backdropPath,
        widget.movie.voteAverage,
        widget.movie.genres,
        widget.movie.overview,
        widget.movie.posterPath,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.movie.releaseDate != null
                ? Padding(
                  padding: EdgeInsets.only(top: SizeUtils.normalPadding),
                  child: Text(
                      'Release date : ${widget.movie.releaseDate}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                )
                : Container(),
            ScrollingArtists(
              api: Endpoints.getCreditsUrl(widget.movie.id!),
              title: 'Cast',
              tapButtonText: 'See full cast & crew',
              onTap: (Cast cast) {
                modalBottomSheetMenu(cast);
              },
            ),
          ],
        ));
  }
}
