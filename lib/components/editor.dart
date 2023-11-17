import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController fieldController;
  final String? label;
  final String? hint;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final IconData? icon;
  const Editor(
      {required this.fieldController,
      this.label,
      this.hint,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left!, top!, right!, bottom!),
      child: TextField(
        controller: fieldController,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}