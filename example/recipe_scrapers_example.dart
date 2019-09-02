import 'package:recipe_scrapers/recipe_scrapers.dart';
import 'package:html/parser.dart';
import 'package:recipe_scrapers/src/Utils.dart';

import "package:path/path.dart" show dirname;
import 'dart:io';

main() {


  print(Directory.current.path);

  // final String input = File('').readAsStringSync();
  File f = File('${Directory.current.path}\\test\\data\\allrecipes.testhtml');

  
  // print(f.readAsStringSync());
  String input = f.readAsStringSync();

  var test = parse(input);

  // print('Title:');
  // print(test.querySelector('h1').text);


  // print('Total Time:');
  // print(test.querySelector('span.ready-in-time').text);


  // print('Yields:');
  // print(test.querySelector('#metaRecipeServings').attributes['content'].toString());

  // print('Ingredients');
  
  // var ing = test.querySelectorAll('li.checkList__line');
  // ing.removeWhere(
  //   (element) { 
  //     if({'Add all ingredients to list', '', 'ADVERTISEMENT'}.contains(normalize_string(element.text))) return true; 
  //     return false; });

  // print(ing.map(
  //   (li) { 
  //     return normalize_string(li.text);
  //   } 
  //   ).toList().toString());

  // var inst = test.querySelectorAll('span.recipe-directions__list--item');
  // print(inst.map((inst) => normalize_string(inst.text)).toList().toString());

  // print('Ratings');
  // var rating = test.querySelector('meta[property="og:rating"]');
  // print(rating.attributes.toString());

  
}
