import 'package:flutter/material.dart';

class RenderPost extends StatelessWidget {
  final String postText;

  const RenderPost({
    super.key,
    required this.postText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(9, 32, 63, 1),
            Color.fromRGBO(83, 120, 149, 1),
          ],
          // Gradient colors for a lively look
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 8,
            offset: Offset(0, 4), // Deeper shadow for better elevation effect
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post text section
          Text(
            postText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.5, // Increased line height for better readability
            ),
          ),
          const SizedBox(height: 12),
          // Like button with interaction effect
          GestureDetector(
            onTap: () {
              // Handle the like functionality here
              print("Post liked!");
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 5),
                const Text(
                  'Like',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
