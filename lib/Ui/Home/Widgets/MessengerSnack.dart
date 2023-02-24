import 'package:flutter/material.dart';

class MessengerSnack extends StatelessWidget {
  final String message;
  const MessengerSnack({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.2,
      content:  Text(message),
      backgroundColor: Colors.green,
    );
  }
}
