import 'package:flutter/material.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';
import 'package:tm_demo/screens/details/movie_detail_widget.dart';
import 'package:tm_demo/screens/home/movie_home_widget.dart';
import 'package:tm_demo/screens/search/movie_search_view.dart';
import 'package:tm_demo/screens/search/search_view.dart';
import 'package:tm_demo/screens/home/tv_home_widget.dart';
import 'package:tm_demo/screens/search/tv_search_view.dart';
import 'package:tm_demo/utils/app_routes.dart';
import 'package:tm_demo/utils/size_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum DrawerItems { movies, tvShows }

class _HomePageState extends State<HomePage> {
  DrawerItems selectedItemIndex = DrawerItems.movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          getTitle(),
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: expandSearchView,
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        child: ListView(
          padding: EdgeInsets.only(
              top: SizeUtils.xxxLargePadding,
              left: SizeUtils.normalPadding,
              right: SizeUtils.normalPadding),
          children: [
            ListTile(
              title: const Text('Movies'),
              onTap: () => updateSelectedIndex(DrawerItems.movies),
            ),
            ListTile(
              title: const Text('TV Shows'),
              onTap: () => updateSelectedIndex(DrawerItems.tvShows),
            ),
          ],
        ),
      ),
      body: getSelectedWidget(),
    );
  }

  expandSearchView() async {
    switch (selectedItemIndex) {
      case DrawerItems.tvShows:
        final TvShow? result = await showSearch<TvShow?>(
            context: context, delegate: TvSearchView());
        if (result != null) {
          Navigator.pushNamed(context, AppRoutes.tvShowDetails,
              arguments: {'tv_show': result});
        }
        return;
      default:
        final Movie? result = await showSearch<Movie?>(
            context: context, delegate: MovieSearchView());
        if (result != null) {
          Navigator.pushNamed(context, AppRoutes.movieDetails,
              arguments: {'movie': result});
        }
    }
  }

  updateSelectedIndex(DrawerItems itemId) {
    Navigator.pop(context);
    setState(() {
      selectedItemIndex = itemId;
    });
  }

  String getTitle() {
    switch (selectedItemIndex) {
      case DrawerItems.tvShows:
        return "TV Shows";
      default:
        return "Movies";
    }
  }

  Widget getSelectedWidget() {
    switch (selectedItemIndex) {
      case DrawerItems.tvShows:
        return const TvHomeWidget();
      default:
        return const MovieHomeWidget();
    }
  }
}
