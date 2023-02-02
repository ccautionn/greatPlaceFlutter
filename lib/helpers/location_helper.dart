import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = "AIzaSyDl2_fWUTg4IeXEHt9TnXsIFWSv6tbKH44";

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longtitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAdress(double lat, double lng) async {
    final params = {'latlng': '$lat,$lng', 'key': GOOGLE_API_KEY};
    Uri url =
        Uri.https('maps.googleapis.com', '/maps/api/geocode/json', params);

    final response = await http.get(url);

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
