import 'package:flutter/material.dart';

class SnackbarService {
  final BuildContext context;
  SnackbarService(this.context);
  void showSnackbar({required String message}) {
    SnackBar snackbar = SnackBar(
      content: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(Icons.info),
          ),
          const Expanded(child: SizedBox(width: 10)),
          Expanded(
            flex: 9,
            child: Text(
              message,
              style: const TextStyle(
                fontFamily: 'VazirLight',
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
