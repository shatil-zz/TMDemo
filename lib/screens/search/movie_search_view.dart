import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/search/movie_search_result_widget.dart';
import 'package:tm_demo/screens/search/search_bloc.dart';
import 'package:tm_demo/screens/search/search_view.dart';

class MovieSearchView extends SearchView<Movie> {
  MovieSearchView();

  @override
  String getSuggestionText() {
    return 'Enter a Movie to search.';
  }

  @override
  Widget buildResults(BuildContext context) {
    return Provider<SearchBloc>(
      create: (context) => SearchBloc(),
      dispose: (BuildContext context, Bloc bloc) => bloc.dispose(),
      child: MovieSearchResultWidget(
        query: query,
        onTap: (movie) {
          close(context, movie);
        },
      ),
    );
  }
}
