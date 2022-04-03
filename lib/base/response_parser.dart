import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/genres.dart';
import 'package:tm_demo/models/movie.dart';

class ResponseParser {
  static T fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case Movie:
        return Movie.fromJson(json) as T;
      case Credits:
        return Credits.fromJson(json) as T;
      case Genres:
        return Genres.fromJson(json) as T;
      case MovieList:
        return MovieList.fromJson(json) as T;
    }
    throw UnimplementedError("Model not added in ResponseParser");
  }

  static List<T> fromList<T>(List<dynamic> list) {
    List<T> modelList = [];
    for (Map<String, dynamic> json in list) {
      modelList.add(ResponseParser.fromJson<T>(json));
    }
    return modelList;
  }
}
