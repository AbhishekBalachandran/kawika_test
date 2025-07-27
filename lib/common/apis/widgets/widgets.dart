import 'package:flutter/material.dart';

customSnackbar(BuildContext context, {required String content}) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(content), showCloseIcon: true));
}
