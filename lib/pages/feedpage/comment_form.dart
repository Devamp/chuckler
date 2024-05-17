
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../DatabaseQueries.dart';
import '../../Session.dart';
import 'package:chuckler/database/models.dart';

class CommentForm extends StatefulWidget {
  final DbPost cfData;
  final double screenHeight;
  final double screenWidth;

  const CommentForm({super.key, required this.cfData, required this.screenHeight, required this.screenWidth});

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final myController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _hasInput = false;
  List<DbComment> comments = List<DbComment>.empty(growable: true);

  void getPostComments() async {
    FirebaseFirestore firestore =
    Provider.of<FirebaseFirestore>(context, listen: false);
    comments = await getComments(firestore, widget.cfData.postId!);
    if (comments.isEmpty) {
      comments.add(DbComment("", "No comments right now..."));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPostComments();
    myController.addListener(_checkInput);
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _checkInput() {
    setState(() {
      _hasInput = myController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserService userService = Provider.of<UserService>(context, listen: false);
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(children: [
      Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Text(
                  comments[index].comment!,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                );
              })),
      Expanded(
          flex: 1,
          child: Container(
              constraints: BoxConstraints(
                  minWidth: screenWidth / 1.5, maxWidth: screenWidth / 1.5),
              //color: Colors.white,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                focusNode: _focusNode,
                // autofocus: true,
                controller: myController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: _focusNode.hasFocus ? Colors.amber : Colors.white),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Add a comment',
                  suffixIcon: _hasInput
                      ? IconButton(
                    splashRadius: 16,
                    splashColor: Colors.black,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      FirebaseFirestore firestore =
                      Provider.of<FirebaseFirestore>(context,
                          listen: false);
                      addCommentToPost(firestore, widget.cfData.postId!,
                          userService.userId!, myController.text);
                      comments.add(
                          DbComment("YOUR USERNAME", myController.text));
                      myController.text = "";
                      print(userService.userId!);
                    },
                  )
                      : null,
                ),
              ))),
    ]);
  }
}