// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:carbonix/crypto/crypto_service.dart';
import 'package:carbonix/pages/finance/account_details_modal.widget.dart';
import 'package:carbonix/pages/finance/leaderboard.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final CryptoService _cryptoService = CryptoService();

  dynamic totalBalance;
  bool balanceLoaded = false;

  @override
  void initState() {
    super.initState();
    ;
    _loadCryptoDetails();
  }

  Future<void> _loadCryptoDetails() async {
    await _cryptoService.setAgent();

    dynamic balance =
        await _cryptoService.balanceOf('647c54b7-0478-4fab-9211-b5881d26db91');
    print('Balance: $balance');
    setState(() {
      totalBalance = balance;
      balanceLoaded = true;
    });
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
                    Pressable(
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (_) => AccountDetailsModalWidget(),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ThemeColors.text,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: double.infinity,
                        height: 250.0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.add,
                                        size: 20.0, color: Colors.white)
                                  ]),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1FfmbHfnpaZjKFvyi1okTjJJusN455paPH',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Aarush Yadav • 7710000481',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth * 0.5 - 30,
                          height: (screenWidth * 0.5 - 30) * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.5 - 60,
                                  child: Text(
                                    balanceLoaded
                                        ? '$totalBalance CCTS'
                                        : '...',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.5 - 30,
                          height: (screenWidth * 0.5 - 30) * 0.6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.5 - 60,
                                  child: const Text(
                                    '\$125.9',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    // const Text(
                    //   'Transaction Ledger',
                    //   style: TextStyle(
                    //     fontSize: 24.0,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // ..._transactions.map((transaction) =>
                    // TransactionWidget(transaction: transaction))
                    const Text(
                      'Leaderboard',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Leaderboard(),
                    // SizedBox(
                    //   height: 500.0,
                    //   child: ListView.builder(
                    //     itemCount: _transactions.length,
                    //     itemBuilder: (_, int index) {
                    //       return TransactionWidget(
                    //           transaction: _transactions[index]);
                    //     },
                    //   ),
                    // ),
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
