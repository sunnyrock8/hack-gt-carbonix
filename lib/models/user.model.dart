class User {
  final String id;
  final String walletId;
  final String name;
  final String phone;
  final String countryCode;
  final DateTime dob;
  final String country;
  final TravelMode travelMode;
  final int nTimesTravelledWeekly;
  final int distanceTravelledWeekly;

  User(
      {required this.id,
      required this.walletId,
      required this.name,
      required this.phone,
      required this.countryCode,
      required this.dob,
      required this.country,
      required this.travelMode,
      required this.nTimesTravelledWeekly,
      required this.distanceTravelledWeekly});

  static TravelMode parseTravelMode(int travelMode) {
    switch (travelMode) {
      case 0:
        return TravelMode.car;
      case 1:
        return TravelMode.publicBus;
      case 2:
        return TravelMode.train;
      case 3:
        return TravelMode.metro;
      default:
        return TravelMode.car;
    }
  }
}

enum TravelMode { car, publicBus, train, metro }
