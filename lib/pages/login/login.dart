// login.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';

/// The login page.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// The state for the [LoginPage].
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _invalidLogin = false;

  @override
  void initState() {
    super.initState();
    // Directly set the username field into focus when the site loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocus.requestFocus();
    });
  }

  /// Log in function to authenticate the user with the provided credentials.
  Future<void> _login() async {
    // Try to login the user.
    bool isSuccessful = await User.login(
      context,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!isSuccessful) {
      // Invalid login, clear password field and show error message.
      setState(() {
        _invalidLogin = true;
        _passwordController.clear();
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
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

            // User eMail input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _emailController,
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.login.email'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
            ),
            const SizedBox(height: 12),

            // User password input.
            // TODO: Implement obscureText switch.
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

            // Link to the registration page.
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to the registration page.
                context.go(
                  '/register',
                  extra: DateTime.now().millisecondsSinceEpoch,
                );
              },
              child: Text(Localization.getText('pages.login.linkToRegister')),
            ),
          ],
        ),
      ),
    );
  }
}
