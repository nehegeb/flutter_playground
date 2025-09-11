// login_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
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
  bool _showPassword = false;
  String _errorMessage = '';

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
    bool isSuccessful = true;
    String errorMessage = '';

    // Try to login the user.
    if (isSuccessful) {
      String logginError = await User.login(
        context,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (logginError != '') {
        errorMessage = logginError;
        isSuccessful = false;
      } else {
        isSuccessful = true;
      }
    }

    if (!isSuccessful) {
      // Invalid login, clear password field and show error message.
      setState(() {
        _invalidLogin = true;
        _passwordController.clear();
        _errorMessage = errorMessage;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: !_showPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.login.password'),
                  border: const OutlineInputBorder(),
                  suffixIcon: FocusScope(
                    canRequestFocus: false,
                    child: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
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
              Center(
                child: Text(
                  Localization.getText(_errorMessage),
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            // Link to the registration page.
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to the registration page.
                appRouter.go('/register');
              },
              child: Text(Localization.getText('pages.login.linkToRegister')),
            ),
          ],
        ),
      ),
    );
  }
}
