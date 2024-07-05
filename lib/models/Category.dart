class Category {
  String id;
  String name;
  int score;
  String desc;
  int order;
  int status;
  String created;
  String updated;

  Category({
    this.id = '',
    this.name = '',
    this.score = 0,
    this.desc = '',
    this.order = 0,
    this.status = 0,
    this.created = '',
    this.updated = ''
  });

  void clone(Category category) {
    id = category.id;
    name = category.name;
    score = category.score;
    desc = category.desc;
    status = category.status;
    order = category.order;
    created = category.created;
    updated = category.updated;
  }

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      id: jsonData['id'] ?? '',
      name: jsonData['name'] ?? '',
      score: jsonData['score'] ?? '',
      desc: jsonData['desc'] ?? '',
      order: jsonData['order'] ?? 0,
      status: jsonData['status'] ?? 0,
      created: jsonData['created'] ?? '',
      updated: jsonData['updated'] ?? ''
    );
  }
}

class CategoryList {
  CategoryList({
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
  List<Category>? data;

  factory CategoryList.fromJson(Map<String, dynamic> jsonData) {
    List<Category> data = [];
    if (jsonData['data'] != null) {
      data = (jsonData['data'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return CategoryList(
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