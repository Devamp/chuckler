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
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    Container(
                      color: Colors.black,
                      height: 150,
                      child: Center(
                          child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              constraints: const BoxConstraints(maxWidth: 80),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amberAccent)),
                          Container(
                              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              decoration: const BoxDecoration(

                                  color: Colors.black)
                              //  child: Text("This is some sample text to see how it looks", style: TextStyle(fontSize: 16, color: Colors.white),),
                              ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Text(
                                "THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ))
                        ],
                      )),
                    ),
                    index < posts.length - 1
                        ? const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          )
                        : const SizedBox(height: 50),
                  ]);
                })
            : const Text("You haven't posted anything yet"));
  }
}
