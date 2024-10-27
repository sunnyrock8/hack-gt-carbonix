import 'dart:async';
import 'dart:ui';

import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/models/quote.model.dart';
import 'package:carbonix/models/savings.model.dart';
import 'package:carbonix/models/trip.model.dart';
import 'package:carbonix/pages/home/history.widget.dart';
import 'package:carbonix/pages/home/history_modal.widget.dart';
import 'package:carbonix/pages/home/product.widget.dart';
import 'package:carbonix/provider/user_details.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shake_gesture/shake_gesture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  late Future<Quote> _quoteFuture;
  bool _quoteExpanded = false;

  bool _showQuotes = false;

  final List<Savings> _savings = [
    Savings(
      value: 1300,
      template:
          'With a dollar for a gram of CO2 saved, you could buy<>Aston Martin DB5s',
    ),
    Savings(
      value: 25,
      template: 'CO2 emissions equivalent to the mass of<>Beavers eliminated',
    ),
    Savings(
      value: 336000,
      template: 'CO2 emissions equivalent<>Falcon 9 launches',
    ),
    Savings(
      value: 0.01,
      template:
          'CO2 emissions equivalent to the volume of<>Footballs eliminated',
    ),
  ];
  int _currentSavingType = 0;
  Timer? _factTimer;
  int _currentQuoteNo = 0;

  @override
  void initState() {
    super.initState();
    _getQuote();

    _factTimer = Timer.periodic(const Duration(milliseconds: 3500), (_) {
      setState(() {
        if (++_currentSavingType == _savings.length) _currentSavingType = 0;
      });
    });
  }

  @override
  void dispose() {
    _factTimer?.cancel();
    super.dispose();
  }

  void _getQuote() async {
    _quoteFuture = Future.delayed(const Duration(seconds: 1)).then((_) {
      return Quote(
        author: _currentQuoteNo == 0 ? 'Jochen Jeitz' : 'Willem McDonough',
        quote: _currentQuoteNo == 0
            ? 'Sustainability is no longer about doing less harm. It\'s about doing more good.'
            : 'Sustainability takes forever, and that\'s the point.',
      );
    });
    setState(() {
      _currentQuoteNo++;
    });
    // Map<String, String> headers = {
    //   'x-api-key': 'GbgnlwN+rarR9aNvojyU/g==LlTMaWdJEYfEZpAh'
    // };
    // Dio dio = Dio();
    // _quoteFuture = dio
    //     .request(
    //   'https://api.api-ninjas.com/v1/quotes?category=environmental',
    //   options: Options(
    //     method: 'GET',
    //     headers: headers,
    //   ),
    // )
    //     .then((response) {
    //   if (response.statusCode == 200) {
    //     List<dynamic> quotes = response.data;
    //     if (quotes.isNotEmpty) {
    //       return Quote.fromJson(quotes[0]);
    //     } else {
    //       return Quote.defaultQuote;
    //     }
    //   } else {
    //     return Quote.defaultQuote;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ThemeColors.blue,
      // appBar: toolbarWidget(showBack: true),

      body: ShakeGesture(
        onShake: () {
          if (_showQuotes) return;

          setState(() {
            _showQuotes = true;
          });
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: ListView(
                    children: [
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _showQuotes
                                ? SizedBox(
                                    height: 208.0,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(
                                          bottom: 40.0, left: 30.0),
                                      children: [
                                        Container(
                                          width: 275.0,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 0.45),
                                                offset: Offset(5, 13),
                                                blurRadius: 40.0,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Pressable(
                                              onPressed: () {
                                                setState(() {
                                                  _quoteExpanded =
                                                      !_quoteExpanded;
                                                });
                                              },
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sustainability is no longer about doing less harm. It\'s about doing more good.',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                    'Jochen Jeitz',
                                                    style: TextStyle(
                                                      color:
                                                          ThemeColors.darkGreen,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        Container(
                                          width: 275.0,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 0.45),
                                                offset: Offset(5, 13),
                                                blurRadius: 40.0,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Pressable(
                                              onPressed: () {
                                                setState(() {
                                                  _quoteExpanded =
                                                      !_quoteExpanded;
                                                });
                                              },
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sustainability takes forever, and that\'s the point.',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                    'Willem McDonough',
                                                    style: TextStyle(
                                                      color:
                                                          ThemeColors.darkGreen,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        Container(
                                          width: 275.0,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 0.45),
                                                offset: Offset(5, 13),
                                                blurRadius: 40.0,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Pressable(
                                              onPressed: () {
                                                setState(() {
                                                  _quoteExpanded =
                                                      !_quoteExpanded;
                                                });
                                              },
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'The Earth is what we all have in common.',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                    'Wendell Berry',
                                                    style: TextStyle(
                                                      color:
                                                          ThemeColors.darkGreen,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Consumer<UserDetailsModel>(
                                      builder: (context, userDetails, child) {
                                    return Text(
                                      'Hello, ${(userDetails.user?.name ?? 'User').split(' ')[0]}.',
                                      style: const TextStyle(
                                        fontSize: 40.0,
                                        color: ThemeColors.text,
                                        fontFamily: 'Nohemi',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }),
                                  const Text(
                                    '"The activist is not the man who says the river is dirty. The activist is the man who cleans up the river." — Ross Perot',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: ThemeColors.text,
                                      fontFamily: 'Nohemi',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: ThemeColors.text,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(217, 217, 217, 0.45),
                              offset: Offset(5, 13),
                              blurRadius: 40.0,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: ThemeColors.darkGreen,
                                border: Border.all(
                                    color: ThemeColors.darkGreen, width: 9.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(75.0)),
                              ),
                              width: 150.0,
                              height: 150.0,
                              child: Center(
                                child: Consumer<UserDetailsModel>(
                                    builder: (context, userDetails, child) {
                                  double totalSavings =
                                      userDetails.calculateTotalCO2Saved();
                                  String unit = totalSavings < 1000
                                      ? 'g'
                                      : (totalSavings < 100000 ? 'kg' : 'to');
                                  if (unit == 'kg') {
                                    totalSavings /= 1000;
                                  } else if (unit == 'to') {
                                    totalSavings /= 1000 * 1000;
                                  }
                                  return Text(
                                    '${totalSavings.toStringAsFixed(1)}$unit',
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              child: Pressable(
                                onPressed: () {
                                  setState(() {
                                    _factTimer?.cancel();
                                    _factTimer = Timer.periodic(
                                        const Duration(milliseconds: 3500),
                                        (_) {
                                      setState(() {
                                        if (++_currentSavingType ==
                                            _savings.length) {
                                          _currentSavingType = 0;
                                        }
                                      });
                                    });
                                    if (++_currentSavingType ==
                                        _savings.length) {
                                      _currentSavingType = 0;
                                    }
                                  });
                                },
                                child: Consumer<UserDetailsModel>(builder:
                                    (context, userDetailsModel, child) {
                                  double totalSaved = userDetailsModel
                                          .calculateTotalCO2Saved() /
                                      1000;

                                  double value = totalSaved /
                                      _savings[_currentSavingType].value;
                                  String formattedValue = '';

                                  if (value < 0.0001) {
                                    formattedValue = value.toStringAsFixed(7);
                                  } else if (value < 0.0001) {
                                    formattedValue = value.toStringAsFixed(6);
                                  } else if (value < 0.0001) {
                                    formattedValue = value.toStringAsFixed(5);
                                  } else if (value < 0.001) {
                                    formattedValue = value.toStringAsFixed(4);
                                  } else if (value < 0.01) {
                                    formattedValue = value.toStringAsFixed(3);
                                  } else {
                                    formattedValue = value.toStringAsFixed(2);
                                  }

                                  return RichText(
                                    // textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text:
                                          '${_savings[_currentSavingType].template.split('<>')[0]} ',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: formattedValue,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.darkGreen,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' ${_savings[_currentSavingType].template.split('<>')[1]}',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'My Wishlist',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Consumer<UserDetailsModel>(
                                builder: (context, userDetails, child) {
                              return Text(
                                userDetails.wishlist.isEmpty
                                    ? 'Start by adding products to your wishlist from the shop.'
                                    : 'You can claim the products you love by taking more sustainable rides!',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }),
                            const SizedBox(height: 20.0),
                            Consumer<UserDetailsModel>(
                                builder: (context, userDetails, child) {
                              return SizedBox(
                                height: userDetails.wishlist.isEmpty ? 0 : 250,
                                child: ListView.builder(
                                  itemCount: userDetails.wishlist.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, int index) {
                                    Product product =
                                        userDetails.wishlist[index];

                                    return ProductWidget(product: product);
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'History',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 300.0,
                              child: Consumer<UserDetailsModel>(
                                  builder: (context, userDetails, child) {
                                return ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: userDetails.trips.length,
                                  itemBuilder: (_, int index) {
                                    Trip trip = userDetails.trips[index];
                                    return Pressable(
                                      onPressed: () {
                                        showCupertinoModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              HistoryModalWidget(trip: trip),
                                        );
                                      },
                                      child: History(trip: trip),
                                    );
                                  },
                                );
                              }),
                            ),
                            SizedBox(height: 150.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
