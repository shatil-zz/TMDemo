import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tm_demo/api/services/tv_show_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/credits.dart';

class TvShowDetailsBloc extends Bloc {
  final _creditsSubject = PublishSubject<Resource<Credits>>();

  TvShowDetailsBloc(BuildContext context) : super(context);

  Stream<Resource<Credits>> getCreditList() => _creditsSubject.stream;

  fetchCredits(int id) async {
    _creditsSubject.sink.add(Resource(status: ResourceStatus.loading));
    _creditsSubject.sink
        .add(await getIt.get<TvShowApiService>().getTvShowCredits(id));
  }

  @override
  void dispose() {
    _creditsSubject.close();
  }

  @override
  void init() {
  }
}
