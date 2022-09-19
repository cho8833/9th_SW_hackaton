import 'package:flutter/material.dart';

// void main(List<String> args) {
//   runApp(const CustomAppBarExample());
// }

/// get AppBar Widget for setting height
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
              const Spacer(),
              Row(
                children: const [
                  Icon(Icons.ios_share, size: 30,),
                  SizedBox(width: 10,),

                ],
              )
            ],
          ),
          const Center(
            child: Text('이벤트', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarObj.preferredSize.height);
}


// class CustomAppBarExample extends StatelessWidget {
//   const CustomAppBarExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: CustomAppBar(appBarObj: AppBar()),
//       ),
//     );
//   }
// }
