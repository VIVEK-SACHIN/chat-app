import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_fire_chat_app/Widget/message_Bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    // TODO: implement build
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found'),
          );
        }
        final loadedMessages = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 40),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) {
            final chatmessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;
            final currentMessageUserId = chatmessage["userId"];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage["userId"] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;
            if (!nextUserIsSame) {
              return MessageBubble.first(
                // userImage: userImage,
                // username: username,
                // message: message,
                // isMe: isMe
                userImage: chatmessage['userImage'],
                username: chatmessage['username'],
                message: chatmessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
            return MessageBubble.next(
                message: chatmessage["text"],
                isMe: authenticatedUser.uid == currentMessageUserId);
          },
        );
      },
    );
  }
}
