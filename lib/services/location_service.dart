import 'package:get_country_ip/get_country_ip.dart';

/// Fetches the user's country ISO code using the [get_country_ip] package,
/// which offloads the network call to a background isolate via [compute].
/// Returns `null` on any error so callers can fall back gracefully.
class LocationService {
  static final _ipService = GetCountryIp();

  /// Returns the two-letter ISO 3166-1 alpha-2 country code (e.g. "NG", "US"),
  /// or `null` if the request fails or the status is not "success".
  static Future<String?> fetchCountryCode() async {
    try {
      final location = await _ipService.getIPLocation();
      if (location != null && location['status'] == 'success') {
        return location['countryCode'] as String?;
      }
    } catch (_) {
      // Network error, timeout, etc. — fall through to return null.
    }
    return null;
  }
}
