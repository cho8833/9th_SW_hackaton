import 'package:flutter/cupertino.dart';

class EventCountProvider extends ChangeNotifier {
  int count;
  EventCountProvider({required this.count});
  void plus() {
    count += 1;
    notifyListeners();
  }
}