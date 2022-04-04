import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tm_demo/api/api_client.dart';
import 'package:tm_demo/api/services/movie_service.dart';
import 'package:tm_demo/api/services/tv_show_service.dart';
import 'package:tm_demo/base/base_bloc.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/base/response_parser.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/movie.dart';

Future<Map<String, dynamic>> loadJson(String fileName) async {
  var dir = Directory.current.path;
  final file = File('$dir/test/resource/$fileName.json');
  final json = jsonDecode(await file.readAsString());
  return json;
}

disposeBloc(BuildContext context, Bloc bloc) {
  bloc.dispose();
}

Widget wrapWithMaterialApp(Widget widget) {
  return MaterialApp(home: widget);
}

setWidgetTestConfig() async {
  getIt.registerSingleton(ApiClient('TMDB_API_KEY'));
  MovieApiService movieApiService = MovieApiService();
  // when(movieApiService.getMovieList('now_playing', 1)).thenAnswer((_) async =>
  //     Resource<MovieList>(
  //         status: ResourceStatus.success,
  //         model:
  //             ResponseParser.fromJson<MovieList>(await loadJson('movies'))));
  getIt.registerFactory<MovieApiService>(() => movieApiService);
  getIt.registerFactory<TvShowApiService>(() => TvShowApiService());
}
