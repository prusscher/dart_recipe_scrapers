

import 'package:recipe_scrapers/recipe_scrapers.dart';

main() async {

  var scraper = Scraper.scrape_me('https://www.allrecipes.com/recipe/25489/monterey-chicken/');
  await scraper.fetch();
  
  print(scraper.title() + ' ' + scraper.ingredients().toString());

}
