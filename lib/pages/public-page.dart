import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PublicPage extends StatelessWidget {
  final String username;

  const PublicPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          publicPageHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: publicPageBody(context),
            ),
          ),
        ],
      ),
    );
  }
}

Widget publicPageHeader(BuildContext context) {
  return Container(
    color: Colors.black,
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        const ProfilePicture(
            name: AutofillHints.username, radius: 55, fontsize: 20),
        const SizedBox(height: 12),
        const Text(
          AutofillHints.username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 15),
        const Row(
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '3928',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Posts',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4.2K',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Friends',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '3.9M',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Likes',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            print("Clicked");
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.userPlus,
                color: Colors.black,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Follow',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget publicPageBody(BuildContext context) {
  return Container(
    color: Colors.black,
    height: 500,
    child: const Center(
      child: Text(
        'Public Page Body',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
  );
}
