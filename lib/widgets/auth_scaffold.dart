import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Shared chrome for the Login and Sign-Up screens.
///
/// Both screens are, structurally, the same thing: a scrollable,
/// keyboard-safe page with one centered rounded card. Previously each
/// screen rebuilt that structure itself, so the two forms could drift
/// apart by accident. Pulling it into one widget means any future
/// tweak to the card (padding, radius, max width, scroll behavior)
/// only has to be made once, and Login/Sign-Up are guaranteed to stay
/// visually identical apart from the [child] each one supplies.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  /// The screen-specific content — normally a [Form] containing an
  /// [AuthHeader], the input fields, the primary button, and the
  /// link to the other auth screen.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  // Keeps the card vertically centered on tall screens
                  // while still allowing the page to scroll out of the
                  // way when the keyboard opens on short ones.
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 64).clamp(
                      0,
                      double.infinity,
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppSpacing.authCardMaxWidth,
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 3,
                        shadowColor: Colors.black12,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.cardRadius),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppSpacing.cardPadding),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
