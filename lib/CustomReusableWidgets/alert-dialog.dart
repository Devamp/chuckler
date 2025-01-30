import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String alertMessage;
  final VoidCallback onYesPressed; // Function for "Yes" action
  final VoidCallback onNoPressed; // Function for "No" action (Cancel)
  final String? dialogTitle;

  const CustomAlertDialog({
    super.key,
    required this.alertMessage,
    required this.onYesPressed,
    required this.onNoPressed,
    this.dialogTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      title: Text(dialogTitle ?? 'Confirmation'),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Color(0xFFffd230), fontSize: 22),
      content: Text(alertMessage),
      contentTextStyle: const TextStyle(fontSize: 14, color: Colors.white),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xFFffd230)),
          child: const Text('Cancel'),
          onPressed: onNoPressed, // Execute the onNoPressed function
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          child: const Text('Yes'),
          onPressed: onYesPressed, // Execute the onYesPressed function
        ),
      ],
    );
  }
}
