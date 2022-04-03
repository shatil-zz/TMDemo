import 'package:rxdart/rxdart.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/movie.dart';

class HomeBloc extends Bloc {
  final _nowPlayingListSubject = PublishSubject<Resource<MovieList>>();
  final _upcomingListSubject = PublishSubject<Resource<MovieList>>();
  final _topRatedListSubject = PublishSubject<Resource<MovieList>>();

  Stream<Resource<MovieList>> getNowPlayingList() =>
      _nowPlayingListSubject.stream;

  Stream<Resource<MovieList>> getTopRatedList() =>
      _topRatedListSubject.stream;

  Stream<Resource<MovieList>> getUpcomingList() =>
      _upcomingListSubject.stream;

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
  void dispose() {
    _upcomingListSubject.close();
    _topRatedListSubject.close();
    _nowPlayingListSubject.close();
  }
}
