class Group {
  String id;
  String name;
  int leaderId;
  String leaderName;
  int members;
  String groupNumber;
  String desc;
  int status;
  String created;
  String updated;

  Group({
    this.id = '',
    this.name = '',
    this.leaderId = 0,
    this.leaderName = '',
    this.members = 0,
    this.groupNumber = '',
    this.desc = '',
    this.status = 0,
    this.created = '',
    this.updated = ''
  });

  void clone(Group group) {
    id = group.id;
    name = group.name;
    leaderId = group.leaderId;
    leaderName = group.leaderName;
    members = group.members;
    groupNumber = group.groupNumber;
    desc = group.desc;
    status = group.status;
    created = group.created;
    updated = group.updated;
  }

  factory Group.fromJson(Map<String, dynamic> jsonData) {
    return Group(
      id: jsonData['id'] ?? '',
      name: jsonData['name'] ?? '',
      leaderId: jsonData['leader_id'] ?? 0,
      leaderName: jsonData['leaderName'] ?? '',
      members: jsonData['members'] ?? 0,
      groupNumber: jsonData['group_number'] ?? 0,
      desc: jsonData['desc'] ?? '',
      status: jsonData['status'] ?? 0,
      created: jsonData['created'] ?? '',
      updated: jsonData['updated'] ?? ''
    );
  }
}

class GroupList {
  GroupList({
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
  List<Group>? data;

  factory GroupList.fromJson(Map<String, dynamic> jsonData) {
    List<Group> data = [];
    if (jsonData['data'] != null) {
      data = (jsonData['data'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return GroupList(
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