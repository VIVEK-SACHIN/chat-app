import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:u_fire_chat_app/Widget/chat_messages.dart';
import 'package:u_fire_chat_app/Widget/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    final notificationSettings = await fcm.requestPermission();
    // final token = await fcm
    //     .getToken(); //this token is the address of the device on which the app is running can be used to target different divices
   
    fcm.subscribeToTopic('chat');//whith every device will receive a notification whenever we send a notification to topic chat .
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterChat'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        ),
        body: const Column(children: [
          Expanded(child: ChatMessages()),
          NewMessages(),
        ]));
  }
}
