import 'dart:core';

import 'package:html/dom.dart';
import 'package:recipe_scrapers/src/Exceptions.dart';

/// Slightly modified regex to extract dates. No python named groups or fun stuff :/
final TIME_REGEX = RegExp(r'\b((\d+(\.\d+)?)\s*(h|hr|hrs?|hours?))?(\s*(\d+)\s*(m|min|mins?|minutes?|))?\b');

final SERV_REGEX_NUMBER = RegExp(r'(\D*(\d+)?\D*)');

final SERV_REGEX_ITEMS = RegExp(r'\bsandwiches\b |\btacquitos\b | \bmakes\b', caseSensitive: false);

final SERV_REGEX_TO = RegExp(r'\d+(\s+to\s+|-)\d+', caseSensitive: false);


/// Extracts the total number of minutes from a given html element containing a time string
/// eg. 12-15 Minutes returns 12
/// 1 hour, 12 minutes returns 72
/// etc...
int get_minutes(Element element) {

  try {
    // Get the time string
    String tString = element.text;

    // Check if the time is an estimate and grab the lower bound (ie. 12-15 minutes => [12])
    if(tString.contains('-')) {
      tString = tString.split('-').first;
    }

    // Match with the time regex
    var matched = TIME_REGEX.firstMatch(tString);

    // Total the amount of minutes from the regex
    int minutes = 0;
    if(matched.group(6) != null) minutes = int.parse(matched.group(6));
    if(matched.group(2) != null) minutes += 60 * (int.parse(matched.group(2))); // Hours

    return minutes;

  } catch (e) {
    print('get_minutes() exception caught - ${e.toString()}');
    return 0;
  }
  

}

/// Will return a string of servings or items, if the receipt is for number of items and not servings
/// the method will return the string "x item(s)" where x is the quantity.
/// [element] HTML Element OR String in some cases, either works
/// Returns The number of servings or items.
String get_yields(String element) {
  
  String tstring;
  if(element.runtimeType == String) {
    tstring = element;
  } else {
    tstring = (element as Element).text;
  }

  // Regex that matches strings for variable counts of items
  // '15 to 16 servings' would match and return '15 to 16'
  if(SERV_REGEX_TO.hasMatch(tstring)) {
    tstring = tstring.split(SERV_REGEX_TO.allMatches(tstring).first.toString()).first;
    print('SERV_REGEX_TO match: \'$tstring\'');
  }
  
  // Parse the serving and just grab the numbah
  var matched = num.parse(SERV_REGEX_NUMBER.firstMatch(tstring).group(2)??'0');
  print('matched: \'$matched\'');
  var servings = '${matched} serving(s)';

  if(SERV_REGEX_ITEMS.hasMatch(tstring)) {
    servings = '${matched} item(s)';
  }

  return servings;
}

String normalize_string(String str) => str.replaceAll(RegExp(r'\s+'), ' ').replaceAll('\xa0', ' ').replaceAll("\n", ' ').replaceAll('\t', ' ').trim();
