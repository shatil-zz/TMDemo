import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';

class MovieDetailsBloc extends Bloc {
  final _creditsSubject = BehaviorSubject<Resource<Credits>>();

  Stream<Resource<Credits>> creditListStream() => _creditsSubject.stream;

  Movie movie;

  MovieDetailsBloc(BuildContext context, this.movie) : super(context);

  fetchCredits(int id) async {
    _creditsSubject.sink.add(Resource(status: ResourceStatus.loading));
    _creditsSubject.sink
        .add(await getIt.get<MovieApiService>().getMovieCredits(id));
  }

  @override
  void init() {
    fetchCredits(movie.id!);
  }

  @override
  void dispose() {
    _creditsSubject.close();
  }
}
