import 'package:rxdart/rxdart.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/credits.dart';

class MovieDetailsBloc extends Bloc {
  final _creditsSubject = PublishSubject<Resource<Credits>>();

  Stream<Resource<Credits>> getNowPlayingList() => _creditsSubject.stream;

  fetchCredits(int id) async {
    _creditsSubject.sink.add(Resource(status: ResourceStatus.loading));
    _creditsSubject.sink
        .add(await getIt.get<MovieApiService>().getMovieCredits(id));
  }

  @override
  void dispose() {}
}
