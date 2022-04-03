import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/api/endpoints.dart';
import 'package:tm_demo/models/function.dart';
import 'package:tm_demo/models/movie.dart';

class SearchMovieWidget extends StatefulWidget {
  final String? query;
  final Function(Movie)? onTap;

  SearchMovieWidget({this.query, this.onTap});

  @override
  _SearchMovieWidgetState createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
  List<Movie>? moviesList;

  @override
  void initState() {
    super.initState();
    fetchMovies(Endpoints.movieSearchUrl(widget.query!)).then((value) {
      setState(() {
        moviesList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: moviesList == null
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : moviesList?.isEmpty ?? true
          ? Center(
        child: Text(
          "Oops! couldn't find the movie",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      )
          : ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: moviesList!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                widget.onTap!(moviesList![index]);
              },
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: moviesList![index].posterPath == null
                              ? Image.asset(
                            'assets/images/na.jpg',
                            fit: BoxFit.cover,
                          )
                              : FadeInImage(
                            image: NetworkImage(
                                TMDB_BASE_IMAGE_URL +
                                    'w500/' +
                                    moviesList![index]
                                        .posterPath!),
                            fit: BoxFit.cover,
                            placeholder: const AssetImage(
                                'assets/images/loading.gif'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                moviesList![index].title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    moviesList![index].voteAverage!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1,
                                  ),
                                  const Icon(Icons.star,
                                      color: Colors.green)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Divider(
                      color: Theme.of(context).backgroundColor,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}