import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/home/presentation/widgets/search_screen_widgets.dart';

void main() {
  group('SearchBarInternalWidget Tests', () {
    late TextEditingController controller;
    late FocusNode focusNode;
    late bool clearCalled;
    late bool filterTapped;
    late String lastChangedValue;
    late String lastSubmittedValue;

    setUp(() {
      controller = TextEditingController();
      focusNode = FocusNode();
      clearCalled = false;
      filterTapped = false;
      lastChangedValue = '';
      lastSubmittedValue = '';
    });

    tearDown(() {
      controller.dispose();
      focusNode.dispose();
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: Builder(
          builder: (context) {
            AppResponsive.init(context);
            return Scaffold(
              body: SearchBarInternalWidget(
                key: const ValueKey('search_bar'),
                controller: controller,
                focusNode: focusNode,
                onSubmitted: (value) => lastSubmittedValue = value,
                onChanged: (value) => lastChangedValue = value,
                onClear: () => clearCalled = true,
                onFilterTapped: () => filterTapped = true,
              ),
            );
          }
        ),
      );
    }

    testWidgets('Initial state - no clear button', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byKey(const ValueKey('clear_button')), findsNothing);
      expect(find.byKey(const ValueKey('filter_button')), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });




    testWidgets('onChanged callback works', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextField), 'sushi');
      await tester.pump();

      expect(lastChangedValue, 'sushi');
    });

    testWidgets('Filter button works', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.byKey(const ValueKey('filter_button')));
      await tester.pump();

      expect(filterTapped, isTrue);
    });

    testWidgets('onSubmitted callback works', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextField), 'pasta');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(lastSubmittedValue, 'pasta');
    });
  });

  group('RecentSearchesWidget Tests', () {
    testWidgets('Shows recent searches', (WidgetTester tester) async {
      final recentSearches = ['Pizza', 'Burger', 'Sushi'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecentSearchesWidget(
              key: const ValueKey('recent_searches'),
              recentSearches: recentSearches,
              onClearAll: () {},
              onRemoveSearchTerm: (_) {},
              onTapSearchTerm: (_) {},
            ),
          ),
        ),
      );

      for (final search in recentSearches) {
        expect(find.text(search), findsOneWidget);
      }
      expect(find.byKey(const ValueKey('recent_searches')), findsOneWidget);
    });

    testWidgets('Clear All button works', (WidgetTester tester) async {
      bool clearAllCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecentSearchesWidget(
              recentSearches: ['Pizza', 'Burger'],
              onClearAll: () => clearAllCalled = true,
              onRemoveSearchTerm: (_) {},
              onTapSearchTerm: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Clear All'));
      await tester.pump();

      expect(clearAllCalled, isTrue);
    });
  });

  group('SearchResultsGridWidget Tests', () {
    testWidgets('Displays search results', (WidgetTester tester) async {
      final searchResults = [
        {
          'imagePath': 'assets/pizza.png',
          'name': 'Pizza',
          'price': '12.99',
          'isLiked': 'false'
        },
        {
          'imagePath': 'assets/burger.png',
          'name': 'Burger',
          'price': '8.99',
          'isLiked': 'true'
        }
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchResultsGridWidget(
              key: const ValueKey('search_results'),
              searchResults: searchResults,
              onLikeResultItem: (_, __) {},
              onTapResultItem: (_) {},
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('search_results')), findsOneWidget);
      expect(find.text('Pizza'), findsOneWidget);
      expect(find.text('Burger'), findsOneWidget);
    });
  });

  group('Empty State Widgets Tests', () {
    testWidgets('NotFoundWidget displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const NotFoundWidget(),
          ),
        ),
      );

      expect(find.text(AppStrings.notFound), findsOneWidget);
      expect(find.byIcon(Icons.search_off_outlined), findsOneWidget);
    });

    testWidgets('InitialEmptyStateWidget displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const InitialEmptyStateWidget(),
          ),
        ),
      );

      expect(find.text('Start searching for food, restaurants, etc.'), findsOneWidget);
    });
  });
}