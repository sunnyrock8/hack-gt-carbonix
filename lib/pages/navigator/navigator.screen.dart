import 'package:carbonix/pages/calculator/calculator.screen.dart';
import 'package:carbonix/pages/finance/finance.screen.dart';
import 'package:carbonix/pages/home/home.screen.dart';
import 'package:carbonix/pages/scanner/scanner.screen.dart';
import 'package:carbonix/pages/shop/shop.screen.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:carbonix/widgets/tab_navigation/tab_navigation.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _pageIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    FinanceScreen(),
    ShopScreen(),
    CalculatorScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.blue,
      body: Stack(
        children: [
          _screens[_pageIndex],
          TabNavigationWidget(
            pageIndex: _pageIndex,
            onTabSelected: (int index) {
              setState(() {
                _pageIndex = index;
              });
            },
          ),
          _pageIndex == 0
              ? Positioned(
                  bottom: 120,
                  right: 20,
                  child: Pressable(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialWithModalsPageRoute(
                          builder: (_) => ScannerScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code, size: 24.0, color: Colors.white),
                          SizedBox(width: 10.0),
                          Text(
                            'Scan Code',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
