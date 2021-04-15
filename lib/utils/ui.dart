import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'DISMISS',
        onPressed: () {},
      ),
    ),
  );
}
