import 'package:flutter/material.dart';
import 'package:chuckler/database/models.dart';

class AccountPosts extends StatelessWidget {
  final List<DbPost> posts;

  const AccountPosts({super.key, required this.posts});

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    print('rebuilding');
    return SizedBox(height: screenHeight/1.8, child: posts.isNotEmpty
        ? ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    color: Colors.black,
                    height: 150,
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 12,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Text(
                              'This is a sample post and it can be really long depending on the day YOUR ANSWER HERE!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  index <  posts.length-1 ? const SizedBox(
                    height: 10,
                  ) : const SizedBox(height: 50),
                ],
              );
            })
        : const Text("You haven't posted anything yet"));
  }

}
