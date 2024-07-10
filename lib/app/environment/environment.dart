final class WholletEnvironment {
  final String baseUrl;
  final String baseApi;
  final String storageUrl;
  final String imageUrl;
  final bool isLogEnabled;

  const WholletEnvironment._internal({
    required this.baseUrl,
    required this.baseApi,
    required this.storageUrl,
    required this.imageUrl,
    required this.isLogEnabled,
  });

  factory WholletEnvironment.fromArgument() {
    const env = String.fromEnvironment("env", defaultValue: "development");
    switch (env) {
      case "staging":
        return WholletEnvironment.staging;
      case "production":
        return WholletEnvironment.production;
      default:
        return WholletEnvironment.development;
    }
  }

  static const staging = WholletEnvironment._internal(
    baseUrl: "",
    baseApi: "",
    storageUrl: "",
    imageUrl: "",
    isLogEnabled: true,
  );

  static const production = WholletEnvironment._internal(
    baseUrl: "",
    baseApi: "",
    storageUrl: "",
    imageUrl: "",
    isLogEnabled: false,
  );

  static const development = WholletEnvironment._internal(
    baseUrl: "",
    baseApi: "",
    storageUrl: "",
    imageUrl: "",
    isLogEnabled: true,
  );
}
