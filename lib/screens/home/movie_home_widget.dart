import 'package:flutter/material.dart';
import 'package:tm_demo/api/endpoints.dart';
import 'package:tm_demo/screens/home/scrolling_movies_widget.dart';

class MovieHomeWidget extends StatelessWidget {
  const MovieHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          ScrollingMoviesWidget(
            title: 'Now Playing',
            api: Endpoints.nowPlayingMoviesUrl(1),
          ),
          ScrollingMoviesWidget(
            title: 'Upcoming Movies',
            api: Endpoints.upcomingMoviesUrl(1),
          ),
          ScrollingMoviesWidget(
            title: 'Top Rated',
            api: Endpoints.topRatedUrl(1),
          ),
        ],
      ),
    );
  }
}
