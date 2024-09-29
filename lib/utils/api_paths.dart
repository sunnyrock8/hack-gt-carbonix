enum APIPath {
  sendOTP,
  verifyOTP,
  getUserDetails,
  startJourney,
  endJourney,
  getStations,
  estimateDistance,
  getAllTrips
}

class APIPathHelper {
  static const String _domain = "https://carbonix.pythonanywhere.com/";
  static const String _basePath = "$_domain/api/v1";

  static String getValue(APIPath endpoint) {
    switch (endpoint) {
      case APIPath.sendOTP:
        return "$_basePath/send/otp";
      case APIPath.verifyOTP:
        return "$_basePath/verify/otp";
      case APIPath.getUserDetails:
        return "$_basePath/get/user";
      case APIPath.startJourney:
        return "$_basePath/start/journey";
      case APIPath.endJourney:
        return "$_basePath/end/journey";
      case APIPath.getStations:
        return "$_basePath/stations/list";
      case APIPath.estimateDistance:
        return "$_basePath/estimate/distance";
      case APIPath.getAllTrips:
        return "$_basePath/trips/all";
    }
  }
}
