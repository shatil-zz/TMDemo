import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/genres.dart';
import 'package:tm_demo/screens/details/genre_widget.dart';
import 'package:tm_demo/screens/details/scrolling_artists_widget.dart';
import 'package:tm_demo/utils/size_utils.dart';

class BaseDetails{

  Widget getDetailsWidget(
      BuildContext context,
      String? title,
      String? backdropPath,
      String? averageVote,
      List<Genres>? genres,
      String? overview,
      String? posterPath,
      Widget additionalWidget) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          getBackdropWidget(context, backdropPath),
          Column(
            children: <Widget>[
              getAppBarWidget(context),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Theme.of(context).backgroundColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          title ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                averageVote ?? "0",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeUtils.normalPadding,
                                          right: SizeUtils.normalPadding),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          getGenres(genres),
                                          Text(
                                            'Overview',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Text(
                                            overview ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          additionalWidget
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 40,
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(SizeUtils.normalPadding),
                            child: posterPath == null
                                ? Image.asset(
                                    'assets/images/na.jpg',
                                    fit: BoxFit.cover,
                                  )
                                : FadeInImage(
                                    image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                        'w500/' +
                                        posterPath),
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(
                                        'assets/images/loading.gif'),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getAppBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).backgroundColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget getGenres(List<Genres>? genres) {
    return genres == null || genres.isEmpty
        ? Container()
        : GenreList(genres: genres);
  }

  Widget getBackdropWidget(BuildContext context, String? backdropPath) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              backdropPath == null
                  ? Image.asset(
                      'assets/images/na.jpg',
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      width: double.infinity,
                      height: double.infinity,
                      image: NetworkImage(
                          TMDB_BASE_IMAGE_URL + 'original/' + backdropPath),
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage('assets/images/loading.gif'),
                    ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          Theme.of(context).backgroundColor,
                          Theme.of(context).backgroundColor.withOpacity(0.3),
                          Theme.of(context).backgroundColor.withOpacity(0.2),
                          Theme.of(context).backgroundColor.withOpacity(0.1),
                        ],
                        stops: const [
                          0.0,
                          0.25,
                          0.5,
                          0.75
                        ])),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).backgroundColor,
          ),
        )
      ],
    );
  }
}
