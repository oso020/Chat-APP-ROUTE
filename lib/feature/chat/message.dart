import 'package:chat_app/provider/save_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SaveUser>(context);
    return provider.myUser?.id == message.senderId
        ? SentMessage(
            message: message,
          )
        : ReciveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;
  SentMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message.senderName,
            style: const TextStyle(color: Colors.black),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 12),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child:  Text(message.content,
                style: const TextStyle(color: Colors.white)
            ),
          ),
          Text(
            message.dateTime.toString(),
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}

class ReciveMessage extends StatelessWidget {
  Message message;
  ReciveMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            message.senderName,
            style: const TextStyle(color: Colors.black),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 12),

            decoration:  BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )),
            child:  Text(message.content,
                style: const TextStyle(color: Colors.white)
            ),
          ),
          Text(
            message.dateTime.toString(),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
