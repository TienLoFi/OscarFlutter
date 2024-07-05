class User {
  int id;
  String name;
  String email;
  String avatar;
  int level;
  int score;
  int correctCategories;
  int mostOscar;
  int howMany;
  int verify;
  String roleName;
  int roleId;
  int status;
  String created;
  String updated;
  User({
    this.id = 0,
    this.name = "",
    this.email = "",
    this.avatar = "",
    this.level = 0,
    this.score = 0,
    this.correctCategories = 0,
    this.mostOscar = 0,
    this.howMany = 0,
    this.verify = 0,
    this.roleName = "",
    this.roleId = 0,
    this.status = 0,
    this.created = "",
    this.updated = ""
  });

  void clone(User user) {
    id = user.id;
    name = user.name;
    email = user.email;
    avatar = user.avatar;
    level = user.level;
    score = user.score;
    correctCategories = user.correctCategories;
    mostOscar = user.mostOscar;
    howMany = user.howMany;
    verify = user.verify;
    roleName = user.roleName;
    roleId = user.roleId;
    status = user.status;
    created = user.created;
    updated = user.created;
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {

    return User(
      id: jsonData['id']?? 0,
      name: jsonData['name'] ?? '',
      email: jsonData['email'] ?? '',
      avatar: jsonData['avatar'] ?? '',
      level: jsonData['level']?? 0,
      score: jsonData['score']??0,
      correctCategories: jsonData['correct_categories']?? 0,
      mostOscar: jsonData['most_oscar']??0,
      howMany: jsonData['how_many']??0,
      verify: jsonData['verify'] ??0,
      roleName: jsonData['role_name'] ?? '',
      roleId: jsonData['role_id'] ?? 0,
      status: jsonData['status'] ??0,
      created: jsonData['created'] ?? '',
      updated: jsonData['updated'] ?? ''
    );
}
}


class UserList {
  UserList({
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
  List<User>? data;

  factory UserList.fromJson(Map<String, dynamic> jsonData) {
    List<User> data = [];
    if (jsonData['data'] != null) {
      data = (jsonData['data'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return UserList(
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