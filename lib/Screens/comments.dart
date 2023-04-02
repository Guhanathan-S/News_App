import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final String? urlImg, urlTitle;
  final User? user;
  Comments({this.urlImg, this.urlTitle, this.user});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<String> comments = [];
  void addComment(String text) {
    setState(() {
      comments.add(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Comments",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.urlImg!),
              ),
            ))),
            Text(
              widget.urlTitle!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Ktextfield(addcom: this.addComment),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      subtitle: Text(widget.user!.displayName!),
                      title: Text(comments[index]));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Ktextfield extends StatefulWidget {
  final Function(String)? addcom;
  Ktextfield({this.addcom});
  @override
  _KtextfieldState createState() => _KtextfieldState();
}

class _KtextfieldState extends State<Ktextfield> {
  final TextEditingController textController = TextEditingController();
  void call() {
    widget.addcom!(textController.text);
    FocusScope.of(context).unfocus();
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          prefixIcon: const Icon(
            Icons.comment,
            color: Colors.blueAccent,
          ),
          labelText: "Comment",
          suffixIcon: IconButton(
            splashColor: Colors.blue,
            icon: const Icon(
              Icons.send,
            ),
            color: Colors.blueAccent,
            onPressed: () => call(),
          )),
    );
  }
}
