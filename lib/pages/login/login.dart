// login.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';

/// The login page.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  /// Logout function to clear the current user and navigate to the [LoginPage].
  static void logout(BuildContext context) {
    appUserNotifier.value = null;
    // Navigate to the home page, even if the user is already there.
    context.go('/home', extra: DateTime.now().millisecondsSinceEpoch);
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// The state for the [LoginPage].
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _invalidLogin = false;

  @override
  void initState() {
    super.initState();
    // Directly set the username field into focus when the site loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _usernameFocus.requestFocus();
    });
  }

  /// Log in function to authenticate the user with the provided credentials.
  Future<void> _login() async {
    // Find a user with matching username and password.
    final user = users.cast<dynamic>().firstWhere(
      (u) =>
          u.username == _usernameController.text &&
          u.password == _passwordController.text,
      orElse: () => null,
    );

    if (user != null) {
      // Valid login, set the current user and clear the invalid login state.
      setState(() {
        _invalidLogin = false;
      });

      // Set the user.
      User.setUser(user);

      // Redirect the user.
      if (pendingRedirectUrl != null) {
        // If the user wanted to go to a specific page, redirect there.
        context.go(pendingRedirectUrl!);
        pendingRedirectUrl = null;
      } else {
        // Otherwise, navigate to the home page.
        context.go('/home');
      }
    } else {
      // Invalid login, clear password field and show error message.
      setState(() {
        _invalidLogin = true;
        _passwordController.clear();
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title of the login page.
            Text(
              Localization.getText('pages.login.title'),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Username input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _usernameController,
                focusNode: _usernameFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.login.username'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
            ),
            const SizedBox(height: 12),

            // Password input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.login.password'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) => _login(),
              ),
            ),
            const SizedBox(height: 20),

            // Login button.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(Localization.getText('pages.login.loginButton')),
                ),
              ),
            ),

            // Error message for invalid login.
            if (_invalidLogin) ...[
              const SizedBox(height: 12),
              Text(
                Localization.getText('pages.login.messageInvalidLogin'),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
