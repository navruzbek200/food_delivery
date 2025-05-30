import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:food_delivery/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Payment method selection and Add New Card navigation', (tester) async {
    app.main();
    await tester.pumpAndSettle();


    final goToPaymentBtn = find.byKey(Key('goToPaymentMethods'));
    await tester.tap(goToPaymentBtn);
    await tester.pumpAndSettle();

    expect(find.text('Cash'), findsOneWidget);

    final paypalFinder = find.text('PayPal');
    expect(paypalFinder, findsOneWidget, reason: 'PayPal to\'lov usuli ekranda ko\'rinishi kerak');
    await tester.tap(paypalFinder);
    await tester.pumpAndSettle();

    final radioFinder = find.byWidgetPredicate(
          (widget) => widget is Radio<String> && widget.value == 'paypal' && widget.groupValue == 'paypal',
    );
    expect(radioFinder, findsOneWidget);

    final addNewCardFinder = find.text('Add New Card');
    expect(addNewCardFinder, findsOneWidget);
    await tester.tap(addNewCardFinder);
    await tester.pumpAndSettle();


    expect(find.text('Add New Card'), findsWidgets);


  });
}




