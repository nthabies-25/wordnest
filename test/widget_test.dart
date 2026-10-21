
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordnest/main.dart';

void main() {
  testWidgets('WordNest displays the word generator', (tester) async {
    await tester.pumpWidget(MyApp());

    // Check that the main buttons appear.
    expect(find.text('Like'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Check that the navigation menu exists.
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  
testWidgets('User can add a word to favorites', (tester) async {
  await tester.pumpWidget(MyApp());

  // Find the generated word.
  final wordFinder = find.byType(BigCard);
  expect(wordFinder, findsOneWidget);

  final wordCard = tester.widget<BigCard>(wordFinder);
  final savedWord = wordCard.pair.asLowerCase;

  // Like the word.
  await tester.tap(find.text('Like'));
  await tester.pump();

  // Navigate to Favorites.
  await tester.tap(find.text('Favorites'));
  await tester.pumpAndSettle();

  // Check that the saved word appears in Favorites.
  expect(find.text(savedWord), findsOneWidget);
  }
  );

}
