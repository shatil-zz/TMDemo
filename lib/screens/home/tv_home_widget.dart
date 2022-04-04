import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/home/scrolling_movies_widget.dart';
import 'package:tm_demo/screens/home/scrolling_tv_widget.dart';

class TvHomeWidget extends StatefulWidget {
  const TvHomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TvHomeState();
  }
}

class TvHomeState extends State<TvHomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchList();
  }

  fetchList() async {
    HomeBloc bloc = Provider.of(context, listen: false);
    await bloc.fetchAiringTvList();
    await bloc.fetchPopularTvList();
    await bloc.fetchToRattedTvList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          ScrollingTvWidget(
            title: 'Airing Today',
            stream: Provider.of<HomeBloc>(context).getAiringTvList(),
          ),
          ScrollingTvWidget(
            title: 'Popular',
            stream: Provider.of<HomeBloc>(context).getPopularTvList(),
          ),
          ScrollingTvWidget(
            title: 'Top Rated',
            stream: Provider.of<HomeBloc>(context).getTopRatedTvList(),
          ),
        ],
      ),
    );
  }
}
