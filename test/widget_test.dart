import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter_practice/main.dart';

void main() {
  testWidgets('Converts USD to GBP and updates as the amount changes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CurrencyConverterApp());

    await tester.enterText(find.byKey(const Key('amountInput')), '100');
    await tester.pump();
    expect(find.text('79.00 GBP'), findsOneWidget);
    expect(find.text('1 USD = 0.79 GBP'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('amountInput')), '200');
    await tester.pump();
    expect(find.text('158.00 GBP'), findsOneWidget);
  });

  testWidgets('Swap recalculates the amount and exchange rate',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CurrencyConverterApp());

    await tester.enterText(find.byKey(const Key('amountInput')), '100');
    await tester.tap(find.byKey(const Key('swapCurrencies')));
    await tester.pump();
    expect(find.text('126.58 USD'), findsOneWidget);
    expect(find.text('1 GBP = 1.27 USD'), findsOneWidget);

    // Swapping twice should restore the original direction and result.
    await tester.tap(find.byKey(const Key('swapCurrencies')));
    await tester.pump();
    expect(find.text('79.00 GBP'), findsOneWidget);
  });

  testWidgets('Zero is valid and negative amounts show an error',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CurrencyConverterApp());

    await tester.enterText(find.byKey(const Key('amountInput')), '0');
    await tester.pump();
    expect(find.text('0.00 GBP'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('amountInput')), '-5');
    await tester.pump();
    expect(find.text('Enter a valid, non-negative amount.'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
  });

  testWidgets('Changing either dropdown updates the result immediately',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CurrencyConverterApp());
    await tester.enterText(find.byKey(const Key('amountInput')), '100');
    await tester.pump();

    // Change the target currency: USD -> EUR.
    await tester.ensureVisible(find.byType(DropdownButton<String>).at(1));
    await tester.tap(find.byType(DropdownButton<String>).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('EUR').last);
    await tester.pumpAndSettle();
    expect(find.text('92.00 EUR'), findsOneWidget);

    // Change the source currency: GBP -> EUR.
    await tester.ensureVisible(find.byType(DropdownButton<String>).at(0));
    await tester.tap(find.byType(DropdownButton<String>).at(0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('GBP').last);
    await tester.pumpAndSettle();
    expect(find.text('116.46 EUR'), findsOneWidget);
  });

}

