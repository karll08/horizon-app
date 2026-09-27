import 'package:flutter/material.dart';

/// A [TextFormField] pre-wired to the app's shared input styling.
///
/// Every field on the Login and Sign-Up screens is built with this
/// widget so spacing, icon placement, and validation styling behave
/// identically no matter which screen they appear on. The actual
/// border/fill colors come from the app's global
/// [InputDecorationTheme] (see theme/app_theme.dart) — this widget
/// only supplies the per-field label, icon, and validation logic.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.validator,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  /// Capitalization behavior for the on-screen keyboard, e.g. "words"
  /// for a name field. Defaults to none, which is correct for emails,
  /// usernames, and passwords.
  final TextCapitalization textCapitalization;

  /// Hints the OS autofill/password-manager service uses to offer
  /// saved values (e.g. a saved email or a generated password).
  final Iterable<String>? autofillHints;

  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      // Obscured fields (passwords) should never trigger autocorrect
      // or suggestion popups — both are distracting and can briefly
      // reveal part of what was typed.
      autocorrect: !obscureText,
      enableSuggestions: !obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
