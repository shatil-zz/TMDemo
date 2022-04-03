import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/api/endpoints.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/details/base_details_state.dart';
import 'package:tm_demo/screens/details/movie_details_bloc.dart';
import 'package:tm_demo/screens/details/scrolling_artists_widget.dart';
import 'package:tm_demo/utils/size_utils.dart';
import 'package:tm_demo/utils/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends BaseDetailsState<MovieDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MovieDetailsBloc>(context, listen: false)
        .fetchCredits(widget.movie.id!);
  }

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
            StreamBuilder<Resource<Credits>>(
                stream:
                    Provider.of<MovieDetailsBloc>(context).getNowPlayingList(),
                builder: (context, snapshot) {
                  Widget? messageWidget =
                      getLoadingOrErrorWidget(snapshot.data);
                  if (messageWidget == null && snapshot.data?.model != null) {
                    messageWidget = ScrollingArtists(
                      credits: (snapshot.data?.model)!,
                      onTap: (Cast cast) {
                        modalBottomSheetMenu(cast);
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
