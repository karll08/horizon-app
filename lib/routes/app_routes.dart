/// Centralized route name constants.
///
/// Referencing these constants instead of typing raw strings like
/// '/login' throughout the app avoids typos and makes every
/// Navigator call easy to trace back to a single source of truth.
class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
}
