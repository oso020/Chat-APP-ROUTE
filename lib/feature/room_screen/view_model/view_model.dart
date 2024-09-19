import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/feature/room_screen/view_model/room_screen_connector.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/cupertino.dart';

class RoomViewModel extends ChangeNotifier{
  late RoomScreenConnector roomScreenConnector;

  TextEditingController roomName = TextEditingController();
  TextEditingController roomDesc = TextEditingController();
  final form = GlobalKey<FormState>();

  void addRoom(String roomTitle, String roomDescription,String categoryId)async{
    var room=MyRooms(
        roomId: "",
        roomDesc: roomDescription,
        roomTitle: roomTitle,
        categoryId: categoryId);
    try{
      roomScreenConnector.showLoading("Loading...");

      var response=await DatabaseUtils.addRoomFireStore(room);

      roomScreenConnector.hideLoading();
      roomScreenConnector.showMessage("Added Room","Success","ok");

    }catch(e){
      roomScreenConnector.hideLoading();
      roomScreenConnector.showMessage(e.toString(),"fail","try again");
    }
  }



}