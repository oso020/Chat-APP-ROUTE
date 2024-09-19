import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils{
 static CollectionReference<MyUser> getUserCollection(){
  return  FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),);
  }

 static CollectionReference<MyRooms> getRoomsCollection(){
  return  FirebaseFirestore.instance.collection(MyRooms.roomCollection)
      .withConverter<MyRooms>(fromFirestore: (snapshot, options) => MyRooms.fromJson(snapshot.data()!),
   toFirestore: (value, options) => value.toJson(),);
 }
 static Future<void> addRoomFireStore(MyRooms myRoom)async{
  var docRef=getRoomsCollection().doc();
  myRoom.roomId=docRef.id;
 return docRef.set(myRoom);
 }
 static Future<void> registerUser(MyUser myUser)async{
    return await getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?>getUser(String uid)async{
   var snapShot= await getUserCollection().doc(uid).get();
   return snapShot.data();
  }

 static Stream<QuerySnapshot<MyRooms>>getRooms(){
   return getRoomsCollection().snapshots();

 }

}