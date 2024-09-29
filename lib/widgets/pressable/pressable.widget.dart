import 'package:flutter/material.dart';

class Pressable extends StatefulWidget {
  final Widget child;
  final Function onPressed;
  final bool disabled;

  const Pressable(
      {super.key,
      required this.child,
      required this.onPressed,
      this.disabled = false});

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _tapped ? 0.7 : 1,
      child: GestureDetector(
        child: widget.child,
        onTapDown: (_) {
          if (widget.disabled) return;
          setState(() {
            _tapped = true;
          });
        },
        onTapUp: (_) {
          if (widget.disabled) return;
          setState(() {
            _tapped = false;
          });
        },
        onTap: () {
          if (widget.disabled) return;
          widget.onPressed();
        },
      ),
    );
  }
}
