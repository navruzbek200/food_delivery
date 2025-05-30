import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/home/presentation/widgets/home_widgets/offer_card_widget.dart';

void main() {
  testWidgets('OfferCardWidget renders and interacts correctly', (WidgetTester tester) async {
    bool likedPressed = false;
    bool cardTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            AppResponsive.init(context);
            return Scaffold(
              body: OfferCardWidget(
                imagePath: 'assets/images/sample.png',
                name: 'Test Offer',
                price: '\$10',
                oldPrice: '\$15',
                rating: '4.5',
                isLiked: false,
                onLikePressed: () => likedPressed = true,
                onTap: () => cardTapped = true,
              ),
            );
          }
        ),
      ),
    );

    expect(find.text('Test Offer'), findsOneWidget);
    expect(find.text('\$10'), findsOneWidget);
    expect(find.text('\$15'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);

    await tester.tap(find.byType(InkWell).first);
    await tester.pump();
    expect(cardTapped, isTrue);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(likedPressed, isTrue);
  });

  testWidgets('OfferCardWidget shows filled heart icon when liked', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OfferCardWidget(
            imagePath: 'assets/images/sample.png',
            name: 'Liked Offer',
            price: '\$20',
            isLiked: true,
            onLikePressed: () {},
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
}
