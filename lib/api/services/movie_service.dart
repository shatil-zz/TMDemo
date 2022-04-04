import 'package:tm_demo/api/api_client.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';

const typeNowPlaying = "now_playing",
    typUpcoming = "upcoming",
    typeTopRated = "top_rated";

class MovieApiService {
  Future<Resource<MovieList>> getMovieList(String type, int page) async {
    return getIt.get<ApiClient>().get<MovieList>('/movie/$type?'
        'page=$page');
  }

  Future<Resource<Credits>> getMovieCredits(int id) async {
    return getIt.get<ApiClient>().get<Credits>('/movie/$id/credits');
  }

  Future<Resource<MovieList>> searchMovie(String queryText) {
    return getIt
        .get<ApiClient>()
        .get<MovieList>('/search/movie?query=$queryText');
  }
}
