import 'package:rxdart/rxdart.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/api/services/tv_show_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';

class SearchBloc extends Bloc{
  final _movieSearchSubject = PublishSubject<Resource<MovieList>>();
  final _tvSearchSubject = PublishSubject<Resource<TvShowList>>();

  Stream<Resource<TvShowList>> getTvSearchList() => _tvSearchSubject.stream;

  Stream<Resource<MovieList>> getMovieSearchList() =>
      _movieSearchSubject.stream;

  searchMovieList(String query) async {
    _movieSearchSubject.sink.add(Resource(status: ResourceStatus.loading));
    _movieSearchSubject.sink
        .add(await getIt.get<MovieApiService>().searchMovie(query));
  }

  searchTvList(String query) async {
    _tvSearchSubject.sink.add(Resource(status: ResourceStatus.loading));
    _tvSearchSubject.sink
        .add(await getIt.get<TvShowApiService>().searchTv(query));
  }

  @override
  void dispose() {
    _movieSearchSubject.close();
    _tvSearchSubject.close();
  }
}