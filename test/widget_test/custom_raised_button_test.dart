
import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomRaisedButton(
          child: Text('tap me'),
          onPressed: () => pressed = true,
        ),
      ),
    );
    final button = find.byType(RaisedButton);
    expect(button, findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);
    expect(find.text('tap me'), findsOneWidget);
    await tester.tap(button);
    expect(pressed, true);
  });
}