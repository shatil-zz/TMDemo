import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/tv_show.dart';
import 'package:tm_demo/screens/details/base_details.dart';
import 'package:tm_demo/screens/details/cast_info.dart';
import 'package:tm_demo/screens/details/scrolling_artists_widget.dart';
import 'package:tm_demo/screens/details/tv_show_details_bloc.dart';
import 'package:tm_demo/utils/size_utils.dart';
import 'package:tm_demo/utils/widgets.dart';

class TvDetailPage extends StatelessWidget with BaseDetails{
  final TvShow tvShow;

  const TvDetailPage({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getDetailsWidget(
        context,
        tvShow.title,
        tvShow.backdropPath,
        tvShow.voteAverage,
        tvShow.genres,
        tvShow.overview,
        tvShow.posterPath,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tvShow.lastAirDate != null
                ? Padding(
                    padding: EdgeInsets.only(top: SizeUtils.normalPadding),
                    child: Text(
                      'Last air date : ${tvShow.lastAirDate}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                : Container(),
            StreamBuilder<Resource<Credits>>(
                stream: Provider.of<TvShowDetailsBloc>(context).getCreditList(),
                builder: (context, snapshot) {
                  Widget? messageWidget =
                      getLoadingOrErrorWidget(snapshot.data);
                  if (messageWidget == null && snapshot.data?.model != null) {
                    messageWidget = ScrollingArtists(
                      credits: (snapshot.data?.model)!,
                      onTap: (Cast cast) {
                        castInfoBottomSheetMenu(context, cast);
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
