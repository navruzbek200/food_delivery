import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/home/presentation/widgets/search_screen_widgets.dart';

void main() {

  testWidgets('Search bar calls onChanged when typing', (WidgetTester tester) async {
    String? lastChangedValue;
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            AppResponsive.init(context);
            return Scaffold(
              body: SearchBarInternalWidget(
                controller: controller,
                focusNode: FocusNode(),
                onSubmitted: (_) {},
                onChanged: (value) => lastChangedValue = value,
                onClear: () {},
                onFilterTapped: () {},
              ),
            );
          }
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'burger');
    await tester.pump();

    expect(lastChangedValue, equals('burger'));

    controller.dispose();
  });
}