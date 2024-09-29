import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';

AppBar toolbarWidget({bool showBack = false}) {
  return AppBar(
    backgroundColor: ThemeColors.text,
    toolbarHeight: 80,
    leading: showBack
        ? Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 12.5),
                  Pressable(
                    child: const Icon(
                      Icons.chevron_left,
                      color: ThemeColors.green,
                      size: 30,
                    ),
                    onPressed: () {
                      print('Pressed');
                    },
                  )
                ],
              ),
            ],
          )
        : const SizedBox(),
    actions: [
      Pressable(
        onPressed: () {
          print('Go to profile');
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: ThemeColors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}
