/// Centralized spacing and sizing constants for the auth screens.
///
/// [AuthScaffold] and the Login/Sign-Up forms all read the same
/// handful of numbers from here (card width, corner radius, padding,
/// and the gap between form fields) instead of repeating literal
/// values on every screen. That is what keeps the two forms feeling
/// like the same card even though each one owns its own fields.
class AppSpacing {
  AppSpacing._();

  /// Max width of the Login/Sign-Up card on wide (tablet/desktop) screens.
  static const double authCardMaxWidth = 480;

  /// Corner radius shared by the auth card and the Home "status" card.
  static const double cardRadius = 24;

  /// Inner padding of the auth card.
  static const double cardPadding = 32;

  /// Vertical gap between consecutive form fields.
  static const double fieldGap = 16;

  /// Vertical gap between the last field and the primary action button.
  static const double sectionGap = 28;
}
