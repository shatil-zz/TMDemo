import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/api/api_constants.dart';

import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/base/base_resource.dart';

import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';
import 'package:tm_demo/screens/details/movie_details_bloc.dart';
import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/search/search_bloc.dart';
import 'package:tm_demo/screens/search/search_item_widget.dart';

class TvSearchResultWidget extends StatefulWidget {
  final String? query;
  final Function(TvShow)? onTap;

  const TvSearchResultWidget({Key? key, this.query, this.onTap})
      : super(key: key);

  @override
  _TvSearchResultWidgetState createState() =>
      _TvSearchResultWidgetState();
}

class _TvSearchResultWidgetState extends State<TvSearchResultWidget> {
  Function? onTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SearchBloc>(context, listen: false)
        .searchTvList(widget.query!);
    onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBloc>(builder: (context, bloc, widget) {
      return StreamBuilder<Resource<TvShowList>>(
          stream: bloc.getTvSearchList(),
          builder: (context, snapshot) {
            final tvList = snapshot.data?.model?.tvShows;
            return Container(
              color: Theme.of(context).primaryColor,
              child: tvList == null
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : tvList.isEmpty
                  ? Center(
                child: Text(
                  "Oops! couldn't find the movie",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
                  : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: tvList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          onTap!(tvList[index]);
                        },
                        child: SearchItemWidget(
                          title: tvList[index].title,
                          posterPath: tvList[index].posterPath,
                          voteAverage: tvList[index].voteAverage,
                        )),
                  );
                },
              ),
            );
          });
    });
  }
}
