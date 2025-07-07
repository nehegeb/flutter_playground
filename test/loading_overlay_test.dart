import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/helpers/loading_overlay.dart';

void main() {
  testWidgets('LoadingOverlay shows and hides overlay', (
    WidgetTester tester,
  ) async {
    // Set up a MaterialApp with the LoadingOverlay navigatorKey.
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: LoadingOverlay.navigatorKey,
        home: const Scaffold(body: Text('Home')), // Dummy home.
      ),
    );

    // Overlay should not be present initially.
    expect(find.text('Loading test...'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Show the overlay.
    LoadingOverlay.initiate('Loading test...');
    await tester.pump(); // Let the overlay appear.

    // Overlay should be present.
    expect(find.text('Loading test...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Hide the overlay.
    LoadingOverlay.dismiss();
    await tester.pump(
      const Duration(seconds: 1),
    ); // Wait to let the overlay disappear.

    // Overlay should be gone.
    expect(find.text('Loading test...'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
