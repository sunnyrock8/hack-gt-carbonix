import 'dart:async';

import 'package:carbonix/pages/scanner/scanner.screen.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:slide_action/slide_action.dart';

class TripScreen extends StatefulWidget {
  final int journeyId;
  final String stationId;

  const TripScreen({Key? key, required this.journeyId, required this.stationId})
      : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int _secondsElapsed = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed = timer.tick;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  String _formatTime() {
    int hours = (_secondsElapsed / 3600).floor();
    int minutes = (((_secondsElapsed / 3600) - hours) * 60).floor();
    int seconds = _secondsElapsed - (hours * 3600 + minutes * 60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: ThemeColors.blue,
        body: SafeArea(
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: Container(
              height: screenHeight,
              padding:
                  const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: BorderRadius.all(Radius.circular(125.0))),
                    width: 250.0,
                    height: 250.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _formatTime(),
                            style: const TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    // decoration: const BoxDecoration(
                    //   color: Colors.white,
                    //   boxShadow: const [
                    //     BoxShadow(
                    //       color: Color.fromRGBO(217, 217, 217, 0.5),
                    //       offset: Offset(5, 13),
                    //       blurRadius: 40.0,
                    //     ),
                    //   ],
                    // ),
                    // padding: const EdgeInsets.all(15.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'You will earn ~0.005 CRBX by completing this trip',
                        //   style: TextStyle(
                        //     fontSize: 22.0,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // Text(
                        //   'This equates to about \$25',
                        //   style: TextStyle(
                        //     fontSize: 18.0,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  SlideAction(
                    trackBuilder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(217, 217, 217, 0.5),
                              offset: Offset(5, 13),
                              blurRadius: 40.0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Swipe to end journey",
                          ),
                        ),
                      );
                    },
                    stretchThumb: true,
                    thumbBuilder: (context, state) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    action: () {
                      Navigator.of(context).push(MaterialWithModalsPageRoute(
                        builder: (_) => ScannerScreen(
                          isEnding: true,
                          tripId: widget.journeyId,
                        ),
                      ));
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
