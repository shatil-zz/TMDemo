import 'package:tm_demo/api/api_client.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/main.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';

const typeOnTheAir = 'on_the_air', typePopular = 'popular';

class TvShowApiService {
  Future<Resource<TvShowList>> getTvShowList(String type, int page) async {
    return getIt.get<ApiClient>().get<TvShowList>('/tv/$type?'
        'page=$page');
  }

  Future<Resource<Credits>> getTvShowCredits(int id) async {
    return getIt.get<ApiClient>().get<Credits>('/tv/$id/credits');
  }
}
