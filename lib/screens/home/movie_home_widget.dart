import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/home/scrolling_movies_widget.dart';

class MovieHomeWidget extends StatefulWidget {
  const MovieHomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieHomeState();
  }
}

class MovieHomeState extends State<MovieHomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovieList();
  }

  fetchMovieList() async {
    HomeBloc bloc=Provider.of(context,listen: false);
    await bloc.fetchNowPlayingMovieList();
    await bloc.fetchUpcomingMovieList();
    await bloc.fetchTopRatedMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          ScrollingMoviesWidget(
            title: 'Now Playing',
            stream: Provider.of<HomeBloc>(context).getNowPlayingList(),
          ),
          ScrollingMoviesWidget(
            title: 'Upcoming Movies',
            stream: Provider.of<HomeBloc>(context).getUpcomingList(),
          ),
          ScrollingMoviesWidget(
            title: 'Top Rated',
            stream: Provider.of<HomeBloc>(context).getTopRatedList(),
          ),
        ],
      ),
    );
  }
}
