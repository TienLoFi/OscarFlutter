class Nomination {
  String id;
  String name;
  String year;
  String desc;
  int nominationId;
  String nominationName;
  int status;
  int mostOscar;
  String created;
  String updated;
  Nomination({
    this.id = '',
    this.name = '',
    this.year = '',
    this.desc = '',
    this.nominationId = 0,
    this.nominationName = '',
    this.status = 0,
    this.mostOscar = 0,
    this.created = '',
    this.updated = ''
  });

  void clone(Nomination nomination) {
    id = nomination.id;
    name = nomination.name;
    year = nomination.year;
    desc = nomination.desc;
    nominationId = nomination.nominationId;
    nominationName = nomination.nominationName;
    status = nomination.status;
    mostOscar = nomination.mostOscar;
    created = nomination.created;
    updated = nomination.updated;
  }

  factory Nomination.fromJson(Map<String, dynamic> jsonData) {
    return Nomination(
      id: jsonData['id'] ?? '',
      name: jsonData['name'] ?? '',
      year: jsonData['year'] ?? '',
      desc: jsonData['desc'] ?? '',
      nominationId: jsonData['nomination_id'] ?? '',
      nominationName: jsonData['nomination_name'] ?? '',
      status: jsonData['status'] ?? 0,
      mostOscar: jsonData['most_oscar'] ?? 0,
      created: jsonData['created'] ?? '',
      updated: jsonData['updated'] ?? ''
    );
  }
}

class NominationList {
  NominationList({
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
  List<Nomination>? data;

  factory NominationList.fromJson(Map<String, dynamic> jsonData) {
    List<Nomination> data = [];
    if (jsonData['data'] != null) {
      data = (jsonData['data'] as List<dynamic>)
          .map((e) => Nomination.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return NominationList(
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
      data: data
    );
  }
}