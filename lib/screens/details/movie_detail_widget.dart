import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/details/base_details.dart';
import 'package:tm_demo/screens/details/cast_info.dart';
import 'package:tm_demo/screens/details/movie_details_bloc.dart';
import 'package:tm_demo/screens/details/scrolling_artists_widget.dart';
import 'package:tm_demo/utils/size_utils.dart';
import 'package:tm_demo/utils/widgets.dart';

class MovieDetailPage extends StatelessWidget with BaseDetails{

  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieDetailsBloc movieDetailsBloc=Provider.of<MovieDetailsBloc>(context,listen: false);
    Movie movie=movieDetailsBloc.movie;
    return getDetailsWidget(
      context,
        movie.title,
        movie.backdropPath,
        movie.voteAverage,
        movie.genres,
        movie.overview,
        movie.posterPath,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.releaseDate != null
                ? Padding(
              padding: EdgeInsets.only(top: SizeUtils.normalPadding),
              child: Text(
                'Release date : ${movie.releaseDate}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
                : Container(),
            StreamBuilder<Resource<Credits>>(
                stream: movieDetailsBloc.creditListStream(),
                builder: (context, snapshot) {
                  Widget? messageWidget =
                  getLoadingOrErrorWidget(snapshot.data);
                  if (messageWidget == null && snapshot.data?.model != null) {
                    messageWidget = ScrollingArtists(
                      credits: (snapshot.data?.model)!,
                      onTap: (Cast cast) {
                        castInfoBottomSheetMenu(context,cast);
                      },
                    );
                  } else {
                    messageWidget = Container();
                  }
                  return messageWidget;
                }),
          ],
        ));
  }

}
