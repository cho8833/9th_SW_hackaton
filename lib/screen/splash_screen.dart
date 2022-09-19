

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_hackathon_2022/provider/event_count_provider.dart';
import 'package:sw_hackathon_2022/provider/recent_event_provider.dart';
import 'package:sw_hackathon_2022/provider/recent_witness_provider.dart';
import 'package:sw_hackathon_2022/screen/main_screen.dart';


/// Center Image Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MultiProvider(providers: [
            Provider(create: (_) => RecentEventProvider(),),
            Provider(create: (_) => RecentWitnessProvider()),
            ChangeNotifierProvider(create: (_) => EventCountProvider(count: 0)),
          ] ,child: const MainScreen())
      )
      );
    });
    super.initState();
  }
  final double width = 100;
  final double height = 100;
  final Color bgColor = Colors.white;
  final String filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: const CenterLogo(filePath: 'assets/logo.png'),
                    )
                  ],
                ),
                // const Positioned(
                //   bottom: 50,
                //   child: SizedBox(width: double.infinity, child: BottomLogo(filePath: 'assets/bottom_logo.png')),
                // )
              ],
            )));
  }
}



class CenterLogo extends StatelessWidget {
  const CenterLogo({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(filePath),);
  }
}

class BottomLogo extends StatelessWidget {
  const BottomLogo({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(filePath), height: 50,);
  }
}