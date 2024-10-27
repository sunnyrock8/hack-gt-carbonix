import 'package:carbonix/pages/calculator/calculator_results_modal.widget.dart';
import 'package:carbonix/pages/calculator/transport_card.widget.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int _selectedMode = 0;
  int _selectedUnit = 0;

  double _distanceTravelled = 0;

  final TextEditingController _distanceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _distanceController.addListener(() {
      setState(() {
        _distanceTravelled =
            double.tryParse(_distanceController.value.text) ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _distanceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ThemeColors.blue,
      // appBar: toolbarWidget(showBack: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Carbon Footprint',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: Text(
                        'Calculate how much CO2 your journeys generate.',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          TransportCardWidget(
                            active: _selectedMode == 0,
                            icon: Ionicons.car,
                            name: 'Car',
                            onPressed: () {
                              setState(() {
                                _selectedMode = 0;
                              });
                            },
                          ),
                          TransportCardWidget(
                            active: _selectedMode == 1,
                            icon: Ionicons.bus,
                            name: 'Public Bus',
                            onPressed: () {
                              setState(() {
                                _selectedMode = 1;
                              });
                            },
                          ),
                          TransportCardWidget(
                            active: _selectedMode == 2,
                            icon: Ionicons.train,
                            name: 'Train',
                            onPressed: () {
                              setState(() {
                                _selectedMode = 2;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: (screenWidth * 0.5),
                          child: TextField(
                            controller: _distanceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Distance / week',
                              focusColor: ThemeColors.darkGreen,
                            ),
                            keyboardType: TextInputType.number,
                            // hintText: 'Phone Number',
                            // isLast: true,
                            // width: 250,
                          ),
                        ),
                        Container(
                          height: 64.0,
                          width: (screenWidth * 0.5) - 60,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Pressable(
                                onPressed: () {
                                  setState(() {
                                    _selectedUnit = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedUnit == 0
                                        ? ThemeColors.darkGreen
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(
                                        15.0,
                                      ),
                                    ),
                                  ),
                                  height: 64.0,
                                  width: ((screenWidth * 0.5) - 60) * 0.5,
                                  child: Center(
                                    child: Text(
                                      'km',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: _selectedUnit == 0
                                            ? Colors.white
                                            : ThemeColors.text,
                                        fontWeight: _selectedUnit == 0
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Pressable(
                                onPressed: () {
                                  setState(() {
                                    _selectedUnit = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedUnit == 1
                                        ? ThemeColors.darkGreen
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      bottomRight: Radius.circular(
                                        15.0,
                                      ),
                                    ),
                                  ),
                                  height: 64.0,
                                  width: ((screenWidth * 0.5) - 60) * 0.5,
                                  child: Center(
                                    child: Text(
                                      'mi',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: _selectedUnit == 1
                                            ? Colors.white
                                            : ThemeColors.text,
                                        fontWeight: _selectedUnit == 1
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Opacity(
                      opacity: _distanceTravelled > 0 ? 1.0 : 0.7,
                      child: Pressable(
                        disabled: _distanceTravelled == 0,
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (_) => CalculatorResultsModalWidget(
                                distance: _distanceTravelled,
                                vehicle: _selectedMode,
                                unit: _selectedUnit == 0 ? 'km' : 'mi'),
                          );
                        },
                        child: Container(
                            width: screenWidth,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            decoration: BoxDecoration(
                                color: ThemeColors.darkGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Center(
                              child: Text(
                                'Calculate',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
