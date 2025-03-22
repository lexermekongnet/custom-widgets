/// A class for storing the configuration of the app
class Config {
  /// The domain URL of the app
  static String domainURL = '';

  /// A boolean value to determine if the app is running locally
  static bool local = false;

  /// The user id of the current user
  static String? userId;

  /// The token of the current user
  static String? token;

  /// A method to set the configuration of the app
  static void set({
    String? domain,
    bool? local,
    String? userId,
    String? token,
  }) {
    Config.domainURL = domain ?? Config.domainURL;
    Config.local = local ?? Config.local;
    Config.userId = userId ?? Config.userId;
    Config.token = token ?? Config.token;
  }
}
