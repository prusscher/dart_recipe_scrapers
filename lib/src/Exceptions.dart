

/// Thrown when scraper is not loaded prior to calling scrpaer methods for data
/// Call [fetch] prior to fix the issue. 
class NotLoadedException implements Exception {
  final String error;
  NotLoadedException(this.error);
}

/// Thrown when a function for a given scraper is not implemented
class NotImplemenetedException implements Exception {
  final String error;
  NotImplemenetedException(this.error);
}

/// Thrown when a site does not have the required information on a given recipe page.
class NotAvailableException implements Exception {
  final String reason;
  NotAvailableException({this.reason});
}