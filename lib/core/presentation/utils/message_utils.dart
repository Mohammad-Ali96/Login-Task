import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class MessageUtils {
  static void showErrorMessage(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  static void showMessage(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    ));
  }
}
