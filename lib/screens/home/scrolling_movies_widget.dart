import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/models/function.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/details/movie_detail_widget.dart';

class ScrollingMoviesWidget extends StatefulWidget {
  final String? api, title;

  const ScrollingMoviesWidget({Key? key, this.api, this.title}) : super(key: key);

  @override
  _ScrollingMoviesWidgetState createState() => _ScrollingMoviesWidgetState();
}

class _ScrollingMoviesWidgetState extends State<ScrollingMoviesWidget> {
  List<Movie>? moviesList;

  @override
  void initState() {
    super.initState();
    fetchMovies(widget.api!).then((value) {
      setState(() {
        moviesList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title!,
                  style: Theme.of(context).textTheme.headline5),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: moviesList == null
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: moviesList!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              movie: moviesList![index],
                            )));
                  },
                  child: Hero(
                    tag: '${moviesList![index].id}${widget.title}',
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage(
                                image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                    'w500/' +
                                    moviesList![index].posterPath!),
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                    'assets/images/loading.gif'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              moviesList![index].title!,
                              style:
                              Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}