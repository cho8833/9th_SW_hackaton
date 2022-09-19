import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sw_hackathon_2022/provider/noti_provider.dart';


class NotiCenterScreen extends StatefulWidget {
  const NotiCenterScreen({Key? key}) : super(key: key);

  @override
  State<NotiCenterScreen> createState() => _NotiCenterScreenState();
}

class _NotiCenterScreenState extends State<NotiCenterScreen> {
  NotiProvider provider = NotiProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(appBarObj: AppBar(), title: '공유 알림',),
      body: ListView.builder(
        itemCount: provider.noties.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(provider.noties[index].witness.imagePath, ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                          provider.noties[index].witness.address,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: double.infinity, child: Text('구매자 : ${provider.noties[index].buyer}')),
                                  ],
                                ),
                              ),
                            ),
                            Text(provider.noties[index].time)
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: ElevatedButton(onPressed: () {
                                      setState(() {
                                        provider.deleteNoti(index);
                                        Fluttertoast.showToast(msg: '제보영상이 안전하게 공유되었습니다.');
                                      });
                                    },
                                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                                      child: const Text('수락', style: TextStyle(fontWeight: FontWeight.bold),),
                                    )
                                )
                            ),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                    child: ElevatedButton(onPressed: () {  }, child: Text('거절', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),), style: ElevatedButton.styleFrom(primary: Color(0xffdbdbdb), shadowColor: Colors.transparent),)
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailAppBar({Key? key, required this.title, required this.appBarObj}) : super(key: key);

  final AppBar appBarObj;

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back_ios)),
            ],
          ),
          Center(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarObj.preferredSize.height);
}