import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

class TopbarWidget extends StatelessWidget {
  final bool showBackIcon;
  final String bottomText;

  const TopbarWidget(
      {super.key, required this.showBackIcon, required this.bottomText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
          color: Colors.black),
      child: Stack(
        children: [
          if (showBackIcon)
            const Icon(
              Icons.chevron_left,
              color: ThemeColors.green,
            ),
          Positioned(
            right: 40,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: Image.asset(
                "images/logo.png",
                height: 45,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: Text(
              bottomText,
              style: const TextStyle(
                fontFamily: "Nohemi",
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
