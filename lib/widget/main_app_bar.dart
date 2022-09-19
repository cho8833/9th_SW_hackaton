import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_hackathon_2022/provider/event_count_provider.dart';
import 'package:sw_hackathon_2022/screen/noti_center_screen.dart';

// void main(List<String> args) {
//   runApp(const CustomAppBarExample());
// }

/// get AppBar Widget for setting height
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.appBarObj}) : super(key: key);

  final AppBar appBarObj;

  @override
  Widget build(BuildContext context) {
    EventCountProvider provider = Provider.of<EventCountProvider>(context, listen: false);
    return SafeArea(
      child: Row(
        children: [
          Container(margin: const EdgeInsets.only(top: 10, bottom: 10), child: Image.asset('assets/logo.png', height: 40)),
          const Spacer(),
          SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const NotiCenterScreen()));
                }, icon: const Icon(Icons.notifications_outlined, size: 32,)),
                Consumer<EventCountProvider>(
                  builder: (context, provider, child) {
                    return provider.count > 0 ?
                    const Positioned(
                      top: 9.0,
                      right: 9.0,
                      child: Icon(Icons.brightness_1, size: 10, color: Colors.redAccent,),
                    ) : Container();
                  },
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarObj.preferredSize.height);
}

//
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
