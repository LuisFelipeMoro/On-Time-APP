import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData? icon;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
          icon: icon != null ? Icon(icon, color: Colors.white) : const SizedBox.shrink(),
          label: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}