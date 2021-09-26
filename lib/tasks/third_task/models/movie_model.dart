class MovieModel {
  List<ResultModel> results = [];
  MovieModel.fromJson(Map<String, dynamic> json) {
    json['results'].forEach(
      (value) => results.add(
        ResultModel.fromJson(value),
      ),
    );
  }
}

class ResultModel {
  dynamic adult;
  dynamic id;
  dynamic title;
  dynamic overview;
  dynamic posterPath;
  dynamic releaseDate;
  dynamic popularity;
  dynamic voteAverage;
  ResultModel.fromJson(Map<String, dynamic> json) {
    this.adult = json['adult'];
    this.id = json['id'];
    this.title = json['original_title'];
    this.overview = json['overview'];
    this.popularity = json['popularity'];
    this.posterPath = json['poster_path'];
    this.releaseDate = json['release_date'];
    this.voteAverage = json['vote_average'];
  }
}
