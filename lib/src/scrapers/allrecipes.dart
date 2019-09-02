
import 'dart:core';
import 'package:recipe_scrapers/src/AbstractScraper.dart';
import 'package:recipe_scrapers/src/Exceptions.dart';
import 'package:recipe_scrapers/src/Utils.dart';

class AllRecipes extends AbstractScraper {
 
  @override
  String url;

  @override
  bool test;

  AllRecipes([this.url, this.test=false]) : assert(url != null), super(url, test);

  @override
  String host() => 'allrecipes.com';

  @override
  List<String> ingredients() {
    if(loaded) {
      
      // Grab the ingredient list and remove all unwanted items
      var ing = doc.querySelectorAll('li.checkList__line');
      ing.removeWhere(
        (element) { 
          if({'Add all ingredients to list', '', 'ADVERTISEMENT'}.contains(normalize_string(element.text))) return true; 
          return false; 
        });

      // Return the normalized instructions as a list
      return ing.map((li) => normalize_string(li.text)).toList();

    } else {
      throw NotLoadedException('Called host() but not loaded. Call ..fetch() to fix the issue.');
    }
  }

  @override
  List<String> instructions() {
    if(loaded) {

      var inst = doc.querySelectorAll('span.recipe-directions__list--item');
      return inst.map((inst) => normalize_string(inst.text)).toList()..removeWhere((i) => i == '');

    } else {
      throw NotLoadedException('Called host() but not loaded. Call ..fetch() to fix the issue.');
    }
  }

  @override
  links() => throw NotAvailableException();

  @override
  double ratings() {
    var rating = doc.querySelector('meta[property="og:rating"]');

    if(rating != null && rating.attributes.containsKey('content')) {
      // hahah this is FUCKED
      return double.parse(double.parse(rating.attributes['content']).toStringAsFixed(2));
    } 

    return -1.0;
  }

  @override
  reviews() => throw NotAvailableException();

  @override
  String title() {
    if(loaded) {
      return doc.querySelector('h1').text;
    } else {
      throw NotLoadedException('Called host() but not loaded. Call ..fetch() to fix the issue.');
    }
  }

  @override
  int total_time() {
    if(loaded) {
      return get_minutes(doc.querySelector('span.ready-in-time'));
    } else {
      throw NotLoadedException('Called host() but not loaded. Call ..fetch() to fix the issue.');
    }
  }

  @override
  String yields() {
    if(loaded) {
      return get_yields(doc.querySelector('#metaRecipeServings').attributes['content']);
    } else {
      throw NotLoadedException('Called host() but not loaded. Call ..fetch() to fix the issue.');
    }
  }

}