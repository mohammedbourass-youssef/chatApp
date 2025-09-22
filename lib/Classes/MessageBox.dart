import 'package:flutter/material.dart';

enum Enstatus { succes, failled, doingwork }

class Messagebox {
  static void show(BuildContext context, String message, Enstatus status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _getColor(status),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Color _getColor(Enstatus status) {
    switch (status) {
      case Enstatus.succes:
        return Colors.green;
      case Enstatus.doingwork:
        return Colors.orange;
      case Enstatus.failled:
        return Colors.red;
    }
  }
}
