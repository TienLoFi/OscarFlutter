class Movie {
  String id;
  String name;
  String year;
  String desc;
  int status;
  int mostOscar;
  String created;
  String updated;
  Movie({
    this.id = '',
    this.name = '',
    this.year = '',
    this.desc = '',
    this.status = 0,
    this.mostOscar = 0,
    this.created = '',
    this.updated = ''
  });

  void clone(Movie movie) {
    id = movie.id;
    name = movie.name;
    year = movie.year;
    desc = movie.desc;
    status = movie.status;
    mostOscar = movie.mostOscar;
    created = movie.created;
    updated = movie.updated;
  }

  factory Movie.fromJson(Map<String, dynamic> jsonData) {
    return Movie(
      id: jsonData['id'] ?? '',
      name: jsonData['name'] ?? '',
      year: jsonData['year'] ?? '',
      desc: jsonData['desc'] ?? '',
      status: jsonData['status'] ?? 0,
      mostOscar: jsonData['most_oscar'] ?? 0,
      created: jsonData['created'] ?? '',
      updated: jsonData['updated'] ?? ''
    );
  }
}

class MovieList {
  MovieList({
    this.currentPage = 0,
    this.firstPageUrl = '',
    this.from = 0,
    this.lastPage = 0,
    this.lastPageUrl = '',
    this.nextPageUrl = '',
    this.path = '',
    this.perPage = '',
    this.prevPageUrl = '',
    this.to = 0,
    this.total = 0,
    this.data
  });

  int currentPage;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  String perPage;
  String prevPageUrl;
  int to;
  int total;
  List<Movie>? data;

  factory MovieList.fromJson(Map<String, dynamic> jsonData) {
    List<Movie> data = [];
    if (jsonData['data'] != null) {
      data = (jsonData['data'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return MovieList(
      currentPage: jsonData['current_page'] ?? 1,
      firstPageUrl: jsonData['first_page_url'] ?? '',
      from: jsonData['from'] ?? 1,
      lastPage: jsonData['last_page'] ?? 1,
      lastPageUrl: jsonData['last_page_url'] ?? '',
      nextPageUrl: jsonData['next_page_url'] ?? '',
      path: jsonData['path'] ?? '',
      perPage: jsonData['per_page'] ?? '0',
      prevPageUrl: jsonData['prev_page_url'] ?? '',
      to: jsonData['to'] ?? 1,
      total: jsonData['total'] ?? 0,
      data: data,
    );
  }
}