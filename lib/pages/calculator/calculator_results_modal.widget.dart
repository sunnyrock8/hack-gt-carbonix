import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

List<double> data = [0.030475, 0.007837, 0.015, 0.100, 0.0143, 0.007, 0.030, 0];

// car, train, bus, plane, electric car, biodiesel bus, motorcycle, bicycle
class CalculatorResultsModalWidget extends StatelessWidget {
  final int vehicle;
  final double distance;
  final String unit;

  const CalculatorResultsModalWidget(
      {super.key,
      required this.vehicle,
      required this.distance,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.18,
      child: Scaffold(
        backgroundColor: ThemeColors.blue,
        body: SafeArea(
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(data[vehicle] * distance * (unit == 'km' ? 1 : 1.6)).toStringAsFixed(2)}kg',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: Text(
                      'for every $distance$unit per person.',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
