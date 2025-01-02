import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    required this.porcentage,
    required this.total,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final double porcentage;
  final double total;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          
          Text(
            '${porcentage.formatDecimals()} %',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
         
          Text(
            'S/ ${total.formatDecimals()}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}