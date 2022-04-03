import 'package:tm_demo/base/response_parser.dart';
import 'package:tm_demo/models/genres.dart';

class TvShowList {
  int? page;
  int? totalTvShows;
  int? totalPages;
  List<TvShow>? tvShows;

  TvShowList({this.page, this.totalTvShows, this.totalPages, this.tvShows});

  TvShowList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalTvShows = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      tvShows = [];
      json['results'].forEach((v) {
        tvShows!.add(TvShow.fromJson(v));
      });
    }
  }

}

class TvShow {
  int? voteCount;
  int? id;
  bool? video;
  String? voteAverage;
  String? title;
  double? popularity;
  String? posterPath;
  String? originalLanguage;
  String? originalTitle;
  List<Genres>? genres;
  String? backdropPath;
  bool? adult;
  String? overview;
  String? lastAirDate;

  TvShow(
      {this.voteCount,
        this.id,
        this.video,
        this.voteAverage,
        this.title,
        this.popularity,
        this.posterPath,
        this.originalLanguage,
        this.originalTitle,
        this.genres,
        this.backdropPath,
        this.adult,
        this.overview,
        this.lastAirDate});

  TvShow.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'].toString();
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genres = ResponseParser.fromList(json['genres']??[]);
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    lastAirDate = json['last_air_date'];
  }

}
