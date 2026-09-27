import 'package:flutter/material.dart';

import '../models/home_screen_arguments.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Final screen of the flow. Greets the user by the name captured on
/// either the Sign-Up or Login screen, received through named-route
/// arguments, and can sign the user back out to Login.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  void _handleLogout(BuildContext context) {
    // pushReplacementNamed: Home is removed from the stack so the
    // user can't navigate "back" into a logged-out session.
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  /// Formats "now" as e.g. "September 26, 2026 · 2:41 PM" without
  /// pulling in the `intl` package — this app only ever needs the one
  /// format, so a small helper keeps dependencies at zero.
  String _formattedSignInTime(DateTime time) {
    final month = _monthNames[time.month - 1];
    final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$month ${time.day}, ${time.year} · $hour12:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as HomeScreenArguments?;
    final name = (args == null || args.name.isEmpty) ? 'there' : args.name;
    final signInTime = _formattedSignInTime(DateTime.now());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEAF4F1), Color(0xFFF6F7F5)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.explore_outlined,
                            color: AppColors.textOnPrimary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Horizon',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    Text(
                      'Welcome back,',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$name!',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'You are signed in and ready to explore Horizon.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.textOnPrimary.withValues(
                                alpha: 0.14,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.check_circle_outline,
                              color: AppColors.textOnPrimary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You are all set',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: AppColors.textOnPrimary,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Your account is active and secure.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textOnPrimary
                                            .withValues(alpha: 0.78),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Small account-details summary. Everything shown
                    // here is either the name passed through route
                    // arguments or the current device time — no new
                    // data, navigation, or dependencies were added.
                    _AccountDetailsCard(name: name, signInTime: signInTime),
                    const SizedBox(height: 36),
                    // A single, full-width, clearly labeled action —
                    // easier to find and to tap than a small icon
                    // button, and there's now only one way to log out
                    // instead of two competing controls on the page.
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _handleLogout(context),
                        icon: const Icon(Icons.logout),
                        label: const Text('Log Out'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A neutral card listing a couple of quick facts about the current
/// session. Kept private to this file since it is only ever used on
/// the Home screen.
class _AccountDetailsCard extends StatelessWidget {
  const _AccountDetailsCard({required this.name, required this.signInTime});

  final String name;
  final String signInTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 14),
          _DetailRow(
            icon: Icons.person_outline,
            label: 'Signed in as',
            value: name,
          ),
          const SizedBox(height: 12),
          _DetailRow(
            icon: Icons.schedule_outlined,
            label: 'Session started',
            value: signInTime,
          ),
        ],
      ),
    );
  }
}

/// One "icon + label + value" line inside [_AccountDetailsCard].
class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: textTheme.bodyMedium),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
