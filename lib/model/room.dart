class MyRooms{
  static const String roomCollection="rooms";

  String roomId;
  String roomDesc;
  String roomTitle;
  String categoryId;

  MyRooms({
    required this.roomId,
    required this.roomDesc,
    required this.roomTitle,
    required this.categoryId,
});

  MyRooms.fromJson(Map<String,dynamic>json):this(
  roomId:json["roomId"] ,
  roomDesc: json["roomDesc"],
  roomTitle: json["roomTitle"],
  categoryId:json["categoryId"]
  );

  Map<String,dynamic>toJson(){
    return {
      "roomId":roomId,
      "roomDesc":roomDesc,
      "roomTitle":roomTitle,
      "categoryId":categoryId,
    };
  }

}