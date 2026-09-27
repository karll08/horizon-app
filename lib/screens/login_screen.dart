import 'package:flutter/material.dart';

import '../models/home_screen_arguments.dart';
import '../routes/app_routes.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/primary_button.dart';

/// First screen of the app. Collects an email/username and password,
/// then either signs the user in (-> Home) or sends them to Sign-Up.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    // pushReplacementNamed: Login is removed from the stack so the
    // user can't navigate "back" into the sign-in form once inside.
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.home,
      arguments: HomeScreenArguments(name: _identifierController.text.trim()),
    );
  }

  void _goToSignUp() {
    // pushNamed: Login stays on the stack underneath Sign-Up, so
    // Sign-Up's "back to Login" link can simply pop back to it.
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  void _toggleObscurePassword() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'Horizon',
              subtitle: 'Welcome back. Sign in to continue.',
            ),
            const SizedBox(height: 40),
            AppTextField(
              controller: _identifierController,
              label: 'Email or username',
              icon: Icons.person_outline,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.email,
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter your email or username';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.fieldGap),
            AppTextField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              suffixIcon: IconButton(
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                // Icon reflects the CURRENT state of the field: a
                // slashed eye while the password is hidden, an open
                // eye once it's visible.
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: _toggleObscurePassword,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.sectionGap),
            PrimaryButton(
              label: 'Log In',
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: _goToSignUp,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
