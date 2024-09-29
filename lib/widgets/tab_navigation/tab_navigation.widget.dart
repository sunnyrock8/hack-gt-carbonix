import 'dart:ui';

import 'package:carbonix/pages/assistant/assistant.page.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TabNavigationWidget extends StatelessWidget {
  final int pageIndex;
  final Function onTabSelected;

  const TabNavigationWidget(
      {super.key, required this.pageIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height + 50;

    return Stack(
      children: [
        Positioned(
          top: screenHeight - 150.0,
          left: 20.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: screenWidth - 40.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  border: Border.all(color: ThemeColors.text, width: 2.0),
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(217, 217, 217, 0.45),
                      offset: Offset(5, 13),
                      blurRadius: 40.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Pressable(
                      onPressed: () {
                        onTabSelected(0);
                      },
                      child: Container(
                        height: double.infinity,
                        width: (screenWidth - 104) / 4,
                        decoration: BoxDecoration(
                          color:
                              pageIndex == 0 ? ThemeColors.text : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            pageIndex == 0
                                ? Ionicons.home
                                : Ionicons.home_outline,
                            color: pageIndex == 0
                                ? Colors.white
                                : ThemeColors.text,
                          ),
                        ),
                      ),
                    ),
                    Pressable(
                      onPressed: () {
                        onTabSelected(1);
                      },
                      child: Container(
                        height: double.infinity,
                        width: (screenWidth - 104) / 4,
                        decoration: BoxDecoration(
                          color:
                              pageIndex == 1 ? ThemeColors.text : Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            pageIndex == 1
                                ? Ionicons.card
                                : Ionicons.card_outline,
                            color: pageIndex == 1
                                ? Colors.white
                                : ThemeColors.text,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60.0),
                    Pressable(
                      onPressed: () {
                        onTabSelected(2);
                      },
                      child: Container(
                        height: double.infinity,
                        width: (screenWidth - 104) / 4,
                        decoration: BoxDecoration(
                          color:
                              pageIndex == 2 ? ThemeColors.text : Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            pageIndex == 2
                                ? Ionicons.bag
                                : Ionicons.bag_outline,
                            color: pageIndex == 2
                                ? Colors.white
                                : ThemeColors.text,
                          ),
                        ),
                      ),
                    ),
                    Pressable(
                      onPressed: () {
                        onTabSelected(3);
                      },
                      child: Container(
                        height: double.infinity,
                        width: (screenWidth - 104) / 4,
                        decoration: BoxDecoration(
                          color:
                              pageIndex == 3 ? ThemeColors.text : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            pageIndex == 3
                                ? Ionicons.calculator
                                : Ionicons.calculator_outline,
                            color: pageIndex == 3
                                ? Colors.white
                                : ThemeColors.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight - 162.0,
          left: (screenWidth / 2) - 41,
          child: Pressable(
            onPressed: () {
              Navigator.of(context).push(
                MaterialWithModalsPageRoute(
                  builder: (_) => AssistantPage(),
                ),
              );
            },
            child: Container(
              width: 82.0,
              height: 82.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(41.0),
                ),
                color: ThemeColors.darkGreen,
              ),
              child: const Center(
                child: Icon(
                  Icons.chat,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
