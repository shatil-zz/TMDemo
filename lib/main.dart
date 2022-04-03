import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/api/api_client.dart';
import 'package:tm_demo/api/api_key.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/screens/details/movie_detail_widget.dart';
import 'package:tm_demo/screens/details/movie_details_bloc.dart';
import 'package:tm_demo/screens/details/tv_show_details_bloc.dart';
import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/home/home_page.dart';
import 'package:tm_demo/utils/app_routes.dart';
import 'package:tm_demo/utils/argument_utils.dart';
import 'package:tm_demo/utils/them_utils.dart';

GetIt getIt = GetIt.instance;

void main() {
  registerDependencies();
  runApp(const MyApp());
}
registerDependencies()
{
  getIt.registerSingleton(ApiClient(TMDB_API_KEY));
  getIt.registerFactory<MovieApiService>(() => MovieApiService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDemo',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: Provider<HomeBloc>(
        create: (context) => HomeBloc(),
        dispose: disposeBloc,
        child: const HomePage(),
      ),
      onGenerateRoute: getGenerateRoute,
    );
  }

  Route getGenerateRoute(RouteSettings settings) {
    Widget _widget;
    if (settings.name == AppRoutes.movieDetails) {
      _widget = Provider<MovieDetailsBloc>(
        create: (context) => MovieDetailsBloc(),
        dispose: disposeBloc,
        child:
            MovieDetailPage(movie: getArguments('movie', settings.arguments)),
      );
    } else if (settings.name == AppRoutes.tvshowDetails) {
      _widget = Provider<TvShowDetailsBloc>(
        create: (context) => TvShowDetailsBloc(),
        dispose: disposeBloc,
        child:
            MovieDetailPage(movie: getArguments('tv_show', settings.arguments)),
      );
    } else {
      _widget = Container(
        color: Colors.white,
      );
    }
    return _createRoute(settings, _widget);
  }

  disposeBloc(BuildContext context, Bloc bloc) {
    bloc.dispose();
  }

  Route _createRoute(final RouteSettings _settings, final _widget) {
    return PageRouteBuilder(
      settings: _settings,
      pageBuilder: (context, animation, secondaryAnimation) => _widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
