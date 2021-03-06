import 'package:flutter/material.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/screens/search/movie_search_result_widget.dart';

abstract class SearchView<T> extends SearchDelegate<T?> {
  String getSuggestionText();

  SearchView();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
        hintColor: Theme.of(context).backgroundColor,
        primaryColor: Theme.of(context).primaryColor,
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline1,
        ));
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.search,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(getSuggestionText(),
              style: Theme.of(context).textTheme.bodyText1)
        ],
      )),
    );
  }
}
