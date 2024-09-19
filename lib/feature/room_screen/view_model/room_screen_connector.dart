import '../../../model/my_user.dart';

abstract class RoomScreenConnector{
  void showLoading(String message);
  void hideLoading();
  void showMessage(String message,String title,String actionButtonName,[MyUser? user]);
}