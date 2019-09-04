import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:recipe_scrapers/src/Exceptions.dart';

const Map<String, String> HEADERS = {
  'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7'
};

abstract class AbstractScraper {

  /// Defines if the specfic scraper is running in test mode
  bool test;

  /// Defines if [fetch()] has been run successfully
  bool loaded;

  // URL for the given site to be scraped for ingredients
  final String url;

  /// HTML Doc for the given site, used to scrape info
  Document doc;

  AbstractScraper([this.url, this.test=false]) : assert(url != null);

  /// Fetch the information for a given scraper as async constructors aren't a thing in dart :(
  /// If [test] is true, the url is loaded as a file.
  /// [loaded] becomes true once the operation is complete.
  Future fetch() async {

    // When testing, load from a file rather than the web
    if(test) {
      // Load the local file for testing and read as a string
      String res = await File(url).readAsString();
      doc = parse(res);
    } else {
      // Load the data and save for use in methods
      http.Response res = await http.get(url, headers: HEADERS);
      doc = parse(res.body);
    }

    loaded = true;
    return;
  }

  String host();
  String title()                => throw NotImplemenetedException('title');
  int total_time()              => throw NotImplemenetedException('total_time');
  String yields()               => throw NotImplemenetedException('yields');
  List<String> ingredients()    => throw NotImplemenetedException('ingredients');
  List<String> instructions()   => throw NotImplemenetedException('instructions');
  double ratings()              => throw NotImplemenetedException('ratings');
  String reviews()              => throw NotImplemenetedException('reviews');
  List<String> links()          => throw NotImplemenetedException('links');

}