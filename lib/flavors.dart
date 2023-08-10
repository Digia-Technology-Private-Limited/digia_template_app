enum Flavor {
  dev,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Bytes-Dev';
      case Flavor.production:
        return 'Bytes';
      default:
        return 'title';
    }
  }

}
