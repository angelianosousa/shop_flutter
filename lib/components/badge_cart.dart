import 'package:flutter/material.dart';

class BadgeCart extends StatelessWidget {
  final Widget child;
  final String textValue;
  final Color? color;

  const BadgeCart({
    required this.child,
    required this.textValue,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 4,
          right: 6,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amberAccent,
            ),
            child: Text(
              textValue,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
