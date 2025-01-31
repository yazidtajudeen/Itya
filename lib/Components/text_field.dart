import 'package:flutter/material.dart';
// ignore_for_file: file_names
import 'package:yaz/themes/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Icon? icon;

  const CustomTextField({
    required this.hintText,
    this.controller,
    this.icon,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  late Color _borderColor;

  @override
  void initState() {
    super.initState();
    _borderColor = const Color(0xFFEBF4F1);
    _focusNode.addListener(_updateBorderColor);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_updateBorderColor);
    _focusNode.dispose();
    super.dispose();
  }

  void _updateBorderColor() {
    setState(() {
      _borderColor = _focusNode.hasFocus
          ? const Color(0xFF32838C)
          : const Color(0xFFEBF4F1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 51,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF4F1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor, width: 2),
      ),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              const TextStyle(color: AppColors.lightGrayText, fontSize: 8),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
