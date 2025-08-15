// register.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';

/// The register page.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

/// The state for the [RegisterPage].
class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  bool _invalidRegister = false;

  @override
  void initState() {
    super.initState();
    // Directly set the username field into focus when the site loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _usernameFocus.requestFocus();
    });
  }

  /// Register function to create a new user with the provided credentials.
  Future<void> _register() async {
    // Try to register the new user.
    bool isSuccessful = await User.register(
      context,
      name: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!isSuccessful) {
      // Invalid registration, clear password fields and show error message.
      setState(() {
        _invalidRegister = true;
        _passwordController.clear();
        _confirmPasswordController.clear();
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
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
            // Title of the register page.
            Text(
              Localization.getText('pages.register.title'),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // User name input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _usernameController,
                focusNode: _usernameFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.register.username'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
              ),
            ),
            const SizedBox(height: 12),

            // User eMail input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _emailController,
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.register.email'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
            ),
            const SizedBox(height: 12),

            // TODO: Implement password strength check!
            // TODO: Implement obscureText switch.
            // User password input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: Localization.getText('pages.register.password'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                },
              ),
            ),
            const SizedBox(height: 12),

            // User confirm password input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: Localization.getText(
                    'pages.register.confirmPassword',
                  ),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (_) => _register(),
              ),
            ),
            const SizedBox(height: 20),

            // Register button.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text(
                    Localization.getText('pages.register.registerButton'),
                  ),
                ),
              ),
            ),

            // Error message for invalid registration.
            if (_invalidRegister) ...[
              const SizedBox(height: 12),
              Text(
                Localization.getText('pages.register.messageInvalidRegister'),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
