
class Config {
  static Config? _instance;
  final bool isReleaseMode;
  const Config._internal(this.isReleaseMode);

  factory Config() {
    return _instance!;
  }

  factory Config.initDebug() {
    _instance ??= const Config._internal(false);

    return _instance!;
  }

  factory Config.initRelease() {
    _instance ??= const Config._internal(true);

    return _instance!;
  }
}