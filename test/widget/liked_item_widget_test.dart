import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/features/likes/presentation/widgets/liked_item_card.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

void main() {
  testWidgets('LikedItemCard displays all information and reacts to taps', (WidgetTester tester) async {
    bool tapped = false;
    bool likedPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            AppResponsive.init(context);

            return Scaffold(
              body: LikedItemCard(
                imagePath: 'assets/images/sample.png',
                name: 'Test Food',
                price: '\$10',
                oldPrice: '\$15',
                rating: '4.5',
                isLiked: true,
                onTap: () {
                  tapped = true;
                },
                onLikePressed: () {
                  likedPressed = true;
                },
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('Test Food'), findsOneWidget);
    expect(find.text('\$10'), findsOneWidget);
    expect(find.text('\$15'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);

    await tester.tap(find.byType(LikedItemCard));
    expect(tapped, isTrue);

    await tester.tap(find.byIcon(Icons.favorite));
    expect(likedPressed, isTrue);
  });
}
