import 'dart:io';

import 'package:recipe_scrapers/src/AbstractScraper.dart';
import 'package:recipe_scrapers/src/scrapers/allrecipes.dart';
import 'package:test/test.dart';
import 'package:path/path.dart';

void main() {

  AbstractScraper scraper;

  setUp(() async {
    String path = join(Directory.current.path, 'test', 'data', 'allrecipes.testhtml');
    scraper = AllRecipes(path, true);
    await scraper.fetch();
  });

  test('host()', () {
    expect(scraper.host(), 'allrecipes.com');
  });

  test('title()', () {
    expect(scraper.title(), 'Four Cheese Margherita Pizza');
  });

  test('total_time()', () {
    expect(scraper.total_time(), 40);
  });

  test('yields()', () {
    expect(scraper.yields(), '8 serving(s)');
  });

  test('ingredients()', () {
    expect(['1/4 cup olive oil',
            '1 tablespoon minced garlic',
            '1/2 teaspoon sea salt',
            '8 Roma tomatoes, sliced',
            '2 (12 inch) pre-baked pizza crusts',
            '8 ounces shredded Mozzarella cheese',
            '4 ounces shredded Fontina cheese',
            '10 fresh basil leaves, washed, dried',
            '1/2 cup freshly grated Parmesan cheese',
            '1/2 cup crumbled feta cheese'].length, 
            scraper.ingredients().length);
  });

  test('instructions()', () {

    expect(scraper.instructions(),
      ['Stir together olive oil, garlic, and salt; toss with tomatoes, and allow to stand for 15 minutes. Preheat oven to 400 degrees F (200 degrees C).',
      'Brush each pizza crust with some of the tomato marinade. Sprinkle the pizzas evenly with Mozzarella and Fontina cheeses. Arrange tomatoes overtop, then sprinkle with shredded basil, Parmesan, and feta cheese.',
      'Bake in preheated oven until the cheese is bubbly and golden brown, about 10 minutes.']
    );
  });

  test('ratings()', () {
    expect(4.81, scraper.ratings());
  });

}