import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/presentation/widgets/loading_widget.dart';

void main() {
  group('Presentation - widgets - LoadingWidget', () {
    testWidgets('Should be created', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoadingWidget(),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Please, wait!'), findsOneWidget);
    });
  });
}
