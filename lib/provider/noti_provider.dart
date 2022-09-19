import 'package:flutter/cupertino.dart';
import 'package:sw_hackathon_2022/model/noti.dart';
import 'package:sw_hackathon_2022/model/witness.dart';

class NotiProvider extends ChangeNotifier {
  List<Noti> noties = [
    Noti(
      buyer: '사고자',
      time: '몇초전',
      witness: Witness(
          imagePath: 'assets/witness1.jpeg',
          address: '의창구 창원대로 20',
          date: '2022년 9월 16일 20:00',
          price: 5000,
          direction: '남서'),
    ),
  ];

  void deleteNoti(int index) {
    noties.removeAt(index);
    notifyListeners();
  }
}
