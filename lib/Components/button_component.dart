import 'package:flutter/material.dart';
import 'package:yaz/themes/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double width;
  final double height;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.navyBlue,
    this.textColor = Colors.white,
    this.borderRadius = 12,
    this.width = 325,
    this.height = 57,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (icon != null)
              Positioned(
                right: 20,
                top: 16,
                child: Icon(
                  icon,
                  color: textColor,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
