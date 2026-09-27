import 'package:flutter/material.dart';

/// A full-width primary action button, used for "Log In" and
/// "Sign Up". Keeping it in one widget guarantees the two forms
/// never drift into different button shapes or sizes.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
