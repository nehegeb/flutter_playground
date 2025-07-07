import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/helpers/ui_widgets.dart';

void main() {
  testWidgets('PopupMenuEntryCompact displays child and returns value on tap', (
    WidgetTester tester,
  ) async {
    String? selectedValue;
    final testKey = UniqueKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuEntryCompact(
                    value: 'foo',
                    selected: false,
                    child: Text('Foo', key: testKey),
                  ),
                ],
                onSelected: (value) => selectedValue = value,
                child: const Text('Open Menu'),
              ),
            ),
          ),
        ),
      ),
    );

    // Open the popup menu.
    await tester.tap(find.text('Open Menu'));
    await tester.pumpAndSettle();

    // The child should be visible.
    expect(find.byKey(testKey), findsOneWidget);
    expect(find.text('Foo'), findsOneWidget);

    // Tap the entry.
    await tester.tap(find.byKey(testKey));
    await tester.pumpAndSettle();

    // The value should be returned.
    expect(selectedValue, 'foo');
  });
}
