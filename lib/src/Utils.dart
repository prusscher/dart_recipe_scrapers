import 'dart:core';

final TIME_REGEX = RegExp(r'(\D*(?P<hours>\d+)\s*(hours|hrs|hr|h|Hours|H))?(\D*(?P<minutes>\d+)\s*(minutes|mins|min|m|Minutes|M))?');

final SERV_REGEX_NUMBER = RegExp(r'(\D*(?P<items>\d+)?\D*)');

final SERV_REGEX_ITEMS = RegExp(r'\bsandwiches\b |\btacquitos\b | \bmakes\b', caseSensitive: false);

final SERV_REGEX_TO = RegExp(r'\d+(\s+to\s+|-)\d+', caseSensitive: false);

int get_minutes() {

}

String get_yields() {

}

