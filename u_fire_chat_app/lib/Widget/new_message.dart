import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _messagecontroller = TextEditingController();
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 1, 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messagecontroller,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              decoration:
                  const InputDecoration(labelText: "Send a message ...."),
            ),
          ),
          IconButton(onPressed: _submitmessage, icon: Icon(Icons.send)),
        ],
      ),
    );
  }

  void _submitmessage() async {
    final enteredMessage = _messagecontroller.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    _messagecontroller.clear();
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!["username"],
      'userImage': userData.data()!["image_url"],
    });
  }
}
