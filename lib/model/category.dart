class MyCategory {
  static const String sports="sports";
  static const String movies="movies";
  static const String music="music";
  String id;
  late String title;
  late String image;

  MyCategory({required this.id, required this.title, required this.image});

  MyCategory.fromId(this.id){
    if(id==sports){
      title="Sports";
      image="assets/images/sports.png";
    } else if(id==movies){
      title="Movies";
      image="assets/images/movies.png";
    }else if(id==music){
      title="Music";
      image="assets/images/music.png";
    }
  }

  static List<MyCategory> getCategory() {
    return [
      MyCategory.fromId(sports),
      MyCategory.fromId(movies),
      MyCategory.fromId(music),
    ];
  }
}
