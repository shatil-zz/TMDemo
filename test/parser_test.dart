
import 'package:flutter_test/flutter_test.dart';
import 'package:tm_demo/base/response_parser.dart';
import 'package:tm_demo/models/movie.dart';

import 'test_utils.dart';

void main() {
  group('Parser test', (){
    test('Response Parser Test', () async {
      MovieList movieList=ResponseParser.fromJson<MovieList>(await loadJson('movies'));
      expect(movieList.totalPages, 62);
    });
  });
}
