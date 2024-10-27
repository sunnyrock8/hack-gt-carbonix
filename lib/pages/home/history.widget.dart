import 'package:carbonix/models/station.model.dart';
import 'package:carbonix/models/trip.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final Trip trip;
  final List<Station> _stationsList = [
    Station(
      id: '6f2dd678-9436-4cfa-89af-a0e02c1931e1',
      name: 'Hartsfield-Jackson Airport',
      type: 'Train',
    ),
    Station(
      id: '6f2dd678-9436-4cfa-89af-a0e02c1931e1',
      name: 'Tech Square',
      type: 'Train',
    )
  ];

  History({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    String startStation = _stationsList
        .firstWhere((station) => station.id == trip.startStation)
        .name;
    String endStation = _stationsList
        .firstWhere((station) => station.id == trip.endStation)
        .name;
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: 250.0,
        child: Column(
          children: [
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Container(
            //       width: 120.0,
            //       height: 70.0,
            //       decoration: const BoxDecoration(
            //         color: ThemeColors.darkGreen,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10.0),
            //         ),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           '-2.0kg',
            //           style: TextStyle(
            //             fontSize: 16.0,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10.0),
            //     Container(
            //       width: 120.0,
            //       height: 70.0,
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       decoration: const BoxDecoration(
            //         color: Color.fromRGBO(245, 245, 245, 1.0),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10.0),
            //         ),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           '+0.002 CCTS',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 16.0,
            //             color: ThemeColors.text,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(217, 217, 217, 0.45),
                    offset: Offset(5, 13),
                    blurRadius: 40.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Metro Ride',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18.0,
                        color: ThemeColors.text.withOpacity(0.7),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  RichText(
                    text: TextSpan(
                        text: 'You travelled for ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          const TextSpan(
                            text: '10km ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: 'from ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '$startStation ',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: 'to ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: endStation,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
