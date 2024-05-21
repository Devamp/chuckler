import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePhoto extends StatelessWidget {
  final String username;
  final String? img;
  final double radius;

  const ProfilePhoto(
      {super.key,
      required this.username,
      required this.img,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: img == ""
              ? ProfilePicture(
                  name: username,
                  radius: radius,
                  fontsize: (radius - 10),
                )
              : Container(
                  width: radius * 2,
                  height: radius * 2,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover, // Adjust as needed
                      image: NetworkImage(
                          img!), // Use NetworkImage for network image
                    ),
                  ))),

      ///TODO LOGIC FOR COLOR / SHOW IF STATUS ATTAINED ONLY
      Positioned(
        right: 0,
        left: radius*1.5,
        bottom: 0,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.amberAccent, shape: BoxShape.circle),
            child: SvgPicture.asset(
              'assets/svgfiles/largerBanana.svg',
              fit: BoxFit.contain,
              height: radius/2 + 5, // Set the desired height
            )),
      )
    ]);
  }
}
