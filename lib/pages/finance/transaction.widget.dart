import 'dart:math';

import 'package:carbonix/models/transaction.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(217, 217, 217, 0.45),
            offset: Offset(5, 13),
            blurRadius: 40.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Row(
        children: [
          Text(
            transaction.type == 0 ? 'CR' : 'DB',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: transaction.type == 0 ? ThemeColors.darkGreen : Colors.red,
            ),
          ),
          const SizedBox(width: 30.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${transaction.amount} CBRX',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${transaction.type == 0 ? "From" : "To"} ${transaction.to}'
                        .substring(
                            0,
                            min(
                                transaction.to.length +
                                    (transaction.type == 0 ? 5 : 3),
                                30)) +
                    (transaction.to.length > 30 ? '...' : ''),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
