import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/api/endpoints.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';
import 'package:tm_demo/screens/details/base_details_state.dart';
import 'package:tm_demo/screens/details/movie_details_bloc.dart';
import 'package:tm_demo/screens/details/scrolling_artists_widget.dart';
import 'package:tm_demo/screens/details/tv_show_details_bloc.dart';
import 'package:tm_demo/utils/size_utils.dart';
import 'package:tm_demo/utils/widgets.dart';

class TvDetailPage extends StatefulWidget {
  final TvShow tvShow;

  const TvDetailPage({Key? key, required this.tvShow}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends BaseDetailsState<TvDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TvShowDetailsBloc>(context, listen: false)
        .fetchCredits(widget.tvShow.id!);
  }

  @override
  Widget build(BuildContext context) {
    return getDetailsWidget(
        widget.tvShow.title,
        widget.tvShow.backdropPath,
        widget.tvShow.voteAverage,
        widget.tvShow.genres,
        widget.tvShow.overview,
        widget.tvShow.posterPath,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.tvShow.lastAirDate != null
                ? Padding(
              padding: EdgeInsets.only(top: SizeUtils.normalPadding),
              child: Text(
                'Last air date : ${widget.tvShow.lastAirDate}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
                : Container(),
            StreamBuilder<Resource<Credits>>(
                stream:
                Provider.of<TvShowDetailsBloc>(context).getCreditList(),
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
