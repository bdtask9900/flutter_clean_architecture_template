sealed class Routes {
  Routes._();
  // Route names
  static const String splash = 'splash';
  static const String home = 'home';
  static const String login = 'login';
  static const String signUp = 'sign_up';
  static const String user = 'user';

  // Route paths
  static const String splashPath = '/';
  static const String homePath = '/home';
  static const String loginPath = '/login';
  static const String signUpPath = '/sign_up';
  static const String userPath = '/user';

  static const String userProfilePath = '/user/:id'; // Dynamic parameter
  static const String userSettingsPath = '/user/:id/settings';
}
