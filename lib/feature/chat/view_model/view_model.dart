import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/save_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'chat_screen_connector.dart';

class ChatViewModel extends ChangeNotifier{

  late ChatScreenConnector chatScreenConnector;

  TextEditingController messageController=TextEditingController();
  final ScrollController scrollController = ScrollController();


  late SaveUser currentUser;

  late MyRooms room;
 late Stream<QuerySnapshot<Message>> streamMessage;

  void sendMessage()async{
    Message message =Message(
        roomId: room.roomId,
        content: messageController.text,
        senderId: currentUser.myUser!.id,
        senderName: currentUser.myUser!.userName,
        dateTime: DateTime.now());

    try{
      var result = await DatabaseUtils.insertMessage(message);
      messageController.clear();

    }catch(e){
      chatScreenConnector.showMessage(e.toString());
    }
  }

  void listenUpdateMessage(){
  streamMessage=  DatabaseUtils.getMessageFromFireStore(room.roomId);
  }

}