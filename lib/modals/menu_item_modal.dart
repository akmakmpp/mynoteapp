import 'package:flutter/material.dart';

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({required this.text, required this.icon});

  @override
  String toString() {
    return 'MenuItem({text: $text})';
  }
}
