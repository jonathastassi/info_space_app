import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/presentation/widgets/datatable_custom.dart';
import 'package:info_space_app/shared/widgets/loading_widget.dart';

void main() {
  group('Presentation - widgets - DatatableCustom', () {
    List<String> listMock = ['item 1', 'item 2'];

    testWidgets('When loading is true, should show Loading Widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DatatableCustom<String>(
            onRefresh: () async => null,
            data: listMock,
            itemHeader: [
              DataColumn(label: Text('Item label')),
            ],
            itemRow: (item) => [
              DataCell(Text(item)),
            ],
            loading: true,
          ),
        ),
      );

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets(
      'Should show data',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: DatatableCustom<String>(
              onRefresh: () async => null,
              data: listMock,
              itemHeader: [
                DataColumn(label: Text('DataColumn - Item label')),
              ],
              itemRow: (item) => [
                DataCell(Text(item)),
              ],
              loading: false,
            ),
          ),
        );

        expect(find.text('DataColumn - Item label'), findsOneWidget);
        expect(find.text('item 1'), findsOneWidget);
        expect(find.text('item 2'), findsOneWidget);
      },
    );

    testWidgets(
      'Should call onRefresh on scroll',
      (WidgetTester tester) async {
        bool onRefreshCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Container(
              height: 500,
              child: DatatableCustom<String>(
                onRefresh: () async => onRefreshCalled = true,
                data: listMock,
                itemHeader: [
                  DataColumn(label: Text('DataColumn - Item label')),
                ],
                itemRow: (item) => [
                  DataCell(Text(item)),
                ],
                loading: false,
              ),
            ),
          ),
        );

        await tester.fling(find.text('DataColumn - Item label'),
            const Offset(0.0, 300.0), 1000.0);
        await tester.pump();
        await tester
            .pump(const Duration(seconds: 1)); // finish the scroll animation
        await tester.pump(const Duration(
            seconds: 1)); // finish the indicator settle animation
        await tester.pump(
            const Duration(seconds: 1)); // finish the indicator hide animation
        expect(onRefreshCalled, true);
      },
    );
  });
}
