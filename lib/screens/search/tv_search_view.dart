import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/models/tv_show.dart';
import 'package:tm_demo/screens/search/search_bloc.dart';
import 'package:tm_demo/screens/search/search_view.dart';
import 'package:tm_demo/screens/search/tv_search_result_widget.dart';

class TvSearchView extends SearchView<TvShow> {
  TvSearchView();

  @override
  String getSuggestionText() {
    return 'Enter a tv show to search.';
  }

  @override
  Widget buildResults(BuildContext context) {
    return Provider<SearchBloc>(
      create: (context) => SearchBloc(),
      dispose: (BuildContext context, Bloc bloc) => bloc.dispose(),
      child: TvSearchResultWidget(
        query: query,
        onTap: (tv) {
          close(context, tv);
        },
      ),
    );
  }
}
