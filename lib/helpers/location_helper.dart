const GOOGLE_API_KEY = "AIzaSyDl2_fWUTg4IeXEHt9TnXsIFWSv6tbKH44";

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longtitude&key=$GOOGLE_API_KEY&signature=YOUR_SIGNATURE";
  }
}
