
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:sw_hackathon_2022/model/event.dart';
import 'package:sw_hackathon_2022/provider/recent_witness_provider.dart';
import 'package:sw_hackathon_2022/provider/relate_witness_provider.dart';
import 'package:sw_hackathon_2022/screen/witness_video_screen.dart';
import 'package:sw_hackathon_2022/service/kakao_pay.dart';
import 'package:sw_hackathon_2022/widget/video_controller_overlay.dart';
import 'package:sw_hackathon_2022/widget/detail_app_bar.dart';
import 'package:video_player/video_player.dart';


class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {

  late VideoPlayerController _videoPlayerController;

  RelateWitnessProvider provider = RelateWitnessProvider();

  int touchCount = 1;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset('assets/event.mp4');
    _videoPlayerController.addListener(() {
      setState(() {
      });
    });
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    _videoPlayerController.setLooping(false);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(appBarObj: AppBar(), title: '이벤트',),
      body: SafeArea(
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_videoPlayerController),
                  ControlsOverlay(controller: _videoPlayerController),
                  VideoProgressIndicator(_videoPlayerController, allowScrubbing: true),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.event.address,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                        widget.event.date,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      '목격 영상',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  ListView.builder(
                    itemCount: provider.witnesses.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(0)
                        ),
                        onPressed: () {
                          if (touchCount == 0) {
                            KakaoPay.preparePay().then((value) {
                              AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: value['next_redirect_app_url'],
                                  arguments: {'txn_id' : value['tid']}
                              );
                              intent.launch();
                              touchCount += 1;
                            });
                          }
                          else {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => WitnessVideoScreen(heroTag: 'witness video$index',)));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  child: Hero(
                                    tag: 'witness video${index+1}',
                                    child: Image(
                                      image: AssetImage(provider.witnesses[index].imagePath),
                                    ),
                                  )
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          provider.witnesses[index].date,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.indigo
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${provider.witnesses[index].direction}쪽',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                              color: Colors.indigo
                                          )
                                        ),
                                        const Text(
                                          '에서 촬영된 영상'
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text('${provider.witnesses[index].price}포인트', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.end,),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}