import 'package:flutter/material.dart';
import 'package:chuckler/database/models.dart';

class AccountPosts extends StatelessWidget {
  final List<DbPost> posts;

  const AccountPosts({super.key, required this.posts});

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    print('rebuilding');
    return SizedBox(
        height: screenHeight / 1.8,
        child: posts.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    SizedBox(
                      height: 150,
                      child: Center(
                          child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              constraints: const BoxConstraints(maxWidth: 100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amberAccent)),
                          Container(
                              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              decoration:
                                  const BoxDecoration(color: Colors.black)),
                          Container(
                              margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                              child: Text(
                                "I love this app omg its so fun to work on this app. I cannot wait to finish this app and post it on the app store and make millions!",
                                style: Theme.of(context).textTheme.bodySmall,
                              ))
                        ],
                      )),
                    ),
                    index < posts.length - 1
                        ? const Divider(
                            color: Colors.transparent,
                            thickness: 0.2,
                          )
                        : const SizedBox(height: 50),
                  ]);
                })
            : const Text("You haven't posted anything yet"));
  }
}
