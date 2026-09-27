/// Data passed to the Home screen through named-route arguments.
///
/// [name] drives the welcome message. It carries the full name
/// entered on the Sign-Up screen, or the email/username typed into
/// the Login screen when an existing user signs back in.
class HomeScreenArguments {
  final String name;

  const HomeScreenArguments({required this.name});
}
