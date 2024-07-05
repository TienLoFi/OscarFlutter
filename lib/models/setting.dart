class Setting {
  String id;
  String key;
  String value;

  Setting({
    this.id = '',
    this.key = '',
    this.value = ''
  });

  void clone(Setting setting) {
    id = setting.id;
    key = setting.key;
    value = setting.value;
  }

  factory Setting.fromJson(Map<String, dynamic> jsonData) {
    return Setting(
      id: jsonData['id'] ?? '',
      key: jsonData['key'] ?? '',
      value: jsonData['value'] ?? ''
    );
  }
}