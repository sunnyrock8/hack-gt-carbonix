import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';

class TransportCardWidget extends StatelessWidget {
  final bool active;
  final IconData icon;
  final String name;
  final Function onPressed;

  const TransportCardWidget({
    super.key,
    required this.active,
    required this.icon,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPressed: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20.0),
        child: Opacity(
          opacity: active ? 1 : 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(217, 217, 217, 0.45),
                      offset: Offset(5, 13),
                      blurRadius: 40.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Icon(
                    icon,
                    size: 60.0,
                    color: active ? ThemeColors.darkGreen : ThemeColors.text,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: active ? ThemeColors.darkGreen : ThemeColors.text,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
