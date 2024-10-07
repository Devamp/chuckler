import 'package:flutter/material.dart';

class NoUserPost extends StatelessWidget {
  const NoUserPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "You haven't posted yet...\n",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextSpan(
                    text: 'You can',
                    style: Theme.of(context).textTheme.headlineSmall),
                WidgetSpan(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press action
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.amber)),
                    child: const Text(
                      'Opt Out',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700),
                    ),
                    // Customize button style
                  ),
                ),
                TextSpan(
                    text: '\nor you can',
                    style: Theme.of(context).textTheme.headlineSmall),
                WidgetSpan(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press action
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.amber)),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700),
                    ),
                    // Customize button style
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
