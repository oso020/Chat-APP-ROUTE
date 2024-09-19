import 'package:flutter/cupertino.dart';

import 'chat_screen_connector.dart';

class ChatViewModel extends ChangeNotifier{

  late ChatScreenConnector chatScreenConnector;

  TextEditingController message=TextEditingController();

}