import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_app/core/utils/constants.dart';
import 'package:test_app/core/utils/widgetskeys.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end', () {
    testWidgets('login', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder userNameTextField =
          find.byKey(const ValueKey(WidgetsKeys.usernameTextField));
      await tester.enterText(userNameTextField, username);
      final Finder passwordTextField =
          find.byKey(const ValueKey(WidgetsKeys.passwordTextField));
      await tester.enterText(passwordTextField, password);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(Homepage), findsOneWidget);
    });
  });
}
