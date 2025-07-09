/// module_firebase_screen.dart
///
library module_firebase;

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The Firebase module.
class FirebaseModule extends StatelessWidget {
  const FirebaseModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(Localization.getText('firebaseModule.title'))],
    );
  }
}
