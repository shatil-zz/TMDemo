import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/api/services/tv_show_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';

class HomeBloc extends Bloc {
  final _airingTvListSubject = BehaviorSubject<Resource<TvShowList>>();
  final _popularTvListSubject = BehaviorSubject<Resource<TvShowList>>();
  final _topRatedTvListSubject = BehaviorSubject<Resource<TvShowList>>();

  final _nowPlayingListSubject = BehaviorSubject<Resource<MovieList>>();
  final _upcomingListSubject = BehaviorSubject<Resource<MovieList>>();
  final _topRatedListSubject = BehaviorSubject<Resource<MovieList>>();

  HomeBloc(BuildContext context) : super(context);

  Stream<Resource<MovieList>> getNowPlayingList() =>
      _nowPlayingListSubject.stream;

  Stream<Resource<MovieList>> getTopRatedList() => _topRatedListSubject.stream;

  Stream<Resource<MovieList>> getUpcomingList() => _upcomingListSubject.stream;

  Stream<Resource<TvShowList>> getAiringTvList() => _airingTvListSubject.stream;

  Stream<Resource<TvShowList>> getPopularTvList() =>
      _topRatedTvListSubject.stream;

  Stream<Resource<TvShowList>> getTopRatedTvList() =>
      _popularTvListSubject.stream;

  fetchAiringTvList({int page = 1}) async {
    _airingTvListSubject.sink.add(Resource(status: ResourceStatus.loading));
    _airingTvListSubject.sink.add(await getIt
        .get<TvShowApiService>()
        .getTvShowList(typeOnTheAir, page));
  }

  fetchPopularTvList({int page = 1}) async {
    _topRatedTvListSubject.sink.add(Resource(status: ResourceStatus.loading));
    _topRatedTvListSubject.sink.add(
        await getIt.get<TvShowApiService>().getTvShowList(typePopular, page));
  }

  fetchToRattedTvList({int page = 1}) async {
    _popularTvListSubject.sink.add(Resource(status: ResourceStatus.loading));
    _popularTvListSubject.sink.add(
        await getIt.get<TvShowApiService>().getTvShowList(typeTopRated, page));
  }

  fetchNowPlayingMovieList({int page = 1}) async {
    _nowPlayingListSubject.sink.add(Resource(status: ResourceStatus.loading));
    _nowPlayingListSubject.sink.add(
        await getIt.get<MovieApiService>().getMovieList(typeNowPlaying, page));
  }

  fetchTopRatedMovieList({int page = 1}) async {
    _topRatedListSubject.sink.add(Resource(status: ResourceStatus.loading));
    _topRatedListSubject.sink.add(
        await getIt.get<MovieApiService>().getMovieList(typeTopRated, page));
  }

  fetchUpcomingMovieList({int page = 1}) async {
    _upcomingListSubject.sink.add(Resource(status: ResourceStatus.loading));
    _upcomingListSubject.sink.add(
        await getIt.get<MovieApiService>().getMovieList(typUpcoming, page));
  }




  @override
  void init() {
  }

  @override
  void dispose() {
    _popularTvListSubject.close();
    _topRatedTvListSubject.close();
    _airingTvListSubject.close();
    _nowPlayingListSubject.close();
    _topRatedListSubject.close();
    _upcomingListSubject.close();
  }
}
