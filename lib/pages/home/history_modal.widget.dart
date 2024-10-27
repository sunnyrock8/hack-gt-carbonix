import 'package:carbonix/models/trip.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';

List<String> weeks = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

class HistoryModalWidget extends StatelessWidget {
  final Trip trip;

  const HistoryModalWidget({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ThemeColors.blue,
      body: SafeArea(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: Container(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.type,
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.75,
                  child: Text(
                    '${weeks[trip.startTime.weekday - 1]}, ${trip.startTime.day.toString().padLeft(2, '0')}/${trip.startTime.month.toString().padLeft(2, '0')}/${trip.startTime.year.toString()} ${trip.startTime.hour.toString().padLeft(2, '0')}:${trip.startTime.minute.toString().padLeft(2, '0')} to ${trip.endTime.hour.toString().padLeft(2, '0')}:${trip.endTime.minute.toString().padLeft(2, '0')}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20.0),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: FlutterMap(
                      options: const MapOptions(
                        initialCenter: LatLng(
                          (33.77590000 + 33.63240000) / 2,
                          (84.38900000 + 84.43330000) / 2,
                        ),
                        initialZoom: 9.2,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        const MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(33.77590000, 84.38900000),
                              width: 80,
                              height: 80,
                              child: Icon(
                                Ionicons.location,
                                size: 40.0,
                                color: Colors.green,
                              ),
                            ),
                            Marker(
                              point: LatLng(33.63240000, 84.43330000),
                              width: 80,
                              height: 80,
                              child: Icon(Ionicons.location,
                                  size: 40.0, color: Colors.red),
                            ),
                          ],
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      decoration: const BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${((trip.co2Saved ?? 0) / 1000).toStringAsFixed(2)}kg',
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth - 182,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15.0),
                          const Text(
                            'Emissions Saved',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'The equivalent of ${((trip.co2Saved ?? 0) / 1000 / 336000).toStringAsFixed(6)} Falcon-9 launches.',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth - 182,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15.0),
                          Text(
                            'Credits Gained',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'You made \$12 with this trip.',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 25.0),
                      decoration: const BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${trip.creditsEarned}\nCCTS',
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
