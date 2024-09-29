import 'dart:collection';

import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/models/station.model.dart';
import 'package:carbonix/models/trip.model.dart';
import 'package:carbonix/models/user.model.dart';
import 'package:carbonix/provider/auth.service.dart';
import 'package:carbonix/utils/api_paths.dart';
import 'package:carbonix/utils/network_service.dart';
import 'package:flutter/material.dart';

class UserDetailsModel extends ChangeNotifier {
  User? user = User(
    country: 'India',
    countryCode: '+91',
    id: '123456',
    walletId: '123456',
    name: 'Aarush Yadav',
    phone: '7710000481',
    dob: DateTime(2006, 7, 4),
    travelMode: TravelMode.car,
    nTimesTravelledWeekly: 3,
    distanceTravelledWeekly: 100,
  );

  List<Trip> _trips = [];

  List<Station> _stations = [];

  List<Product> _wishlist = [];

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);
  UnmodifiableListView<Product> get wishlist => UnmodifiableListView(_wishlist);
  UnmodifiableListView<Station> get stations => UnmodifiableListView(_stations);

  void addToWishlist(Product product) {
    _wishlist.add(product);

    notifyListeners();
  }

  void removeFromWishlist(String id) {
    _wishlist.removeWhere((product) => product.id == id);

    notifyListeners();
  }

  void addToStations(Station station) {
    _stations.add(station);

    notifyListeners();
  }

  Future<void> fetchTrips() async {
    print('fetching trips');
    String uid = await AuthenticationService().getUid() ?? '';
    NetworkService().post(
      APIPath.getAllTrips,
      {'user_id': uid},
      (data) {
        print(data['body']['data']);
        _trips.clear();
        data['body']['data'].forEach((trip) {
          // print(Trip.fromJson(trip));
          // _trips.add(Trip.fromJson(trip));
          _trips.add(Trip(
            id: trip['id'],
            startStation: trip['start_stop'],
            endStation: trip['end_stop'],
            startTime: DateTime.parse(trip['start_time']),
            endTime: DateTime.parse(trip['end_time']),
            type: trip['type'],
            inProgress: false,
            co2Saved: double.parse(trip['emission_saved']),
            creditsEarned: double.parse(trip['credits']),
            distanceCovered: double.parse(trip['distance']),
          ));
        });
        notifyListeners();
      },
      print,
      () {},
    );
  }

  double calculateTotalCO2Saved() {
    double sum = 0;
    _trips.forEach((trip) {
      sum += trip.co2Saved ?? 0.0;
    });

    return sum;
  }
}
