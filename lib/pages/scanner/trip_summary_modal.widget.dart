import 'package:carbonix/pages/navigator/navigator.screen.dart';
import 'package:carbonix/provider/user_details.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class TripSummaryModalWidget extends StatelessWidget {
  final int tripId;
  final double creditsSaved;
  final int timeTaken;
  final double carbonSaved;
  final String startStation, endStation;

  const TripSummaryModalWidget({
    super.key,
    required this.tripId,
    required this.creditsSaved,
    required this.timeTaken,
    required this.carbonSaved,
    required this.startStation,
    required this.endStation,
  });

  String _formatTime(int secondsElapsed) {
    int hours = (secondsElapsed / 3600).floor();
    int minutes = (((secondsElapsed / 3600) - hours) * 60).floor();
    int seconds = secondsElapsed - (hours * 3600 + minutes * 60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.6,
      child: SafeArea(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: Container(
            height: screenHeight,
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatTime(timeTaken),
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.75,
                  child: Text(
                    'You travelled from ${startStation} to ${endStation}.',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20.0),
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
                          creditsSaved.toStringAsFixed(3),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
                          Text(
                            'Tokens',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'You earned \$25 on this trip',
                            style: TextStyle(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
                          Text(
                            'Carbon Saved',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'You saved emissions by 25% compared to taking a car.',
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
                          horizontal: 20.0, vertical: 40.0),
                      decoration: const BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${(carbonSaved / 1000).toStringAsFixed(2)}kg',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Consumer<UserDetailsModel>(
                    builder: (context, userDetailsModel, child) {
                  return Pressable(
                    onPressed: () {
                      userDetailsModel.fetchTrips();
                      Navigator.of(context).pushReplacement(
                        MaterialWithModalsPageRoute(
                          builder: (_) => NavigatorScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                      ;
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: ThemeColors.darkGreen,
                      ),
                      width: screenWidth - 40,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: const Center(
                        child: Text(
                          'Finish Journey',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
