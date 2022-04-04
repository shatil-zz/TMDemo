import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/api/api_constants.dart';

import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/base/base_resource.dart';

import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/details/movie_details_bloc.dart';
import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/search/search_bloc.dart';
import 'package:tm_demo/screens/search/search_item_widget.dart';

class MovieSearchResultWidget extends StatefulWidget {
  final String? query;
  final Function(Movie)? onTap;

  const MovieSearchResultWidget({Key? key, this.query, this.onTap})
      : super(key: key);

  @override
  _MovieSearchResultWidgetState createState() =>
      _MovieSearchResultWidgetState();
}

class _MovieSearchResultWidgetState extends State<MovieSearchResultWidget> {
  Function? onTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SearchBloc>(context, listen: false)
        .searchMovieList(widget.query!);
    onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBloc>(builder: (context, bloc, widget) {
      return StreamBuilder<Resource<MovieList>>(
          stream: bloc.getMovieSearchList(),
          builder: (context, snapshot) {
            final moviesList = snapshot.data?.model?.movies;
            return Container(
              color: Theme.of(context).primaryColor,
              child: moviesList == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : moviesList.isEmpty
                      ? Center(
                          child: Text(
                            "Oops! couldn't find the movie",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: moviesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    onTap!(moviesList[index]);
                                  },
                                  child: SearchItemWidget(
                                    title: moviesList[index].title,
                                    posterPath: moviesList[index].posterPath,
                                    voteAverage: moviesList[index].voteAverage,
                                  )),
                            );
                          },
                        ),
            );
          });
    });
  }
}
