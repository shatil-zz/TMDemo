import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'integration_test_utils.dart';
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('View Movie Details', (WidgetTester tester) async {
    await startApp(tester);
    await openFirstMovieItemDetails(tester);
  });
}
