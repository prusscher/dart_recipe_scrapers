import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:beautifulsoup/beautifulsoup.dart';

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

  // The BeautifulSoup object to parse the HTML returned from the site
  Beautifulsoup _soup;

  AbstractScraper([this.url, this.test=false]) : assert(url != null);

  Future fetch() async {

    // When testing, load from a file rather than the web
    if(test) {

      // Load the local file for testing and read as a string
      String res = await File(url).readAsString();
      _soup = Beautifulsoup(res);

    } else {

      // Load the data and save for use in methods
      http.Response res = await http.get(url, headers: HEADERS);
      _soup = Beautifulsoup(res.body);

    }

    loaded = true;
    return;
  }

  String host();
  String title();
  dynamic total_time();
  dynamic yields();
  dynamic ingredients();
  dynamic instructions();
  dynamic ratings();
  dynamic reviews();
  dynamic links();

}