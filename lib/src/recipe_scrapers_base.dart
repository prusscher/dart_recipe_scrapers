


import 'package:recipe_scrapers/src/Exceptions.dart';
import 'package:recipe_scrapers/src/scrapers/allrecipes.dart';

import 'AbstractScraper.dart';


AbstractScraper getScraperFromHost(String host, String url) {
  switch(host) {
    case 'allrecipes.com': return AllRecipes(url);
    default: throw NotImplemenetedException('Website not implemented or unavailable');
  }
}

class Scraper {
  static AbstractScraper scrape_me(String url) {
    return getScraperFromHost(Uri.parse(url.replaceAll('://www.', '://')).host, url);
  }
}
