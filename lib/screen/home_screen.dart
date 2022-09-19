import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_hackathon_2022/provider/event_count_provider.dart';
import 'package:sw_hackathon_2022/provider/recent_event_provider.dart';
import 'package:sw_hackathon_2022/provider/recent_witness_provider.dart';
import 'package:sw_hackathon_2022/screen/event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const SignInView()),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const WelcomeView()),
          const SizedBox(height: 20),
          const RecentEventView(),
          const SizedBox(height: 50),
          const RecentWitnessView()
        ],
      ),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      width: double.infinity,
      child: Row(
        children: const [
          Text(
            '간편하게',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            ' 스마트 로그인',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Text('하세요.', style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: 20,
          )
        ],
      ),
    );
  }
}

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '목격자님 환영합니다',
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
          Text(
            '오늘도 안전운전하세요!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class RecentEventView extends StatefulWidget {
  const RecentEventView({Key? key}) : super(key: key);

  @override
  State<RecentEventView> createState() => _RecentEventViewState();
}

class _RecentEventViewState extends State<RecentEventView> {
  @override
  Widget build(BuildContext context) {
    RecentEventProvider provider = Provider.of<RecentEventProvider>(context);
    EventCountProvider eventCountProvider =
        Provider.of<EventCountProvider>(context, listen: true);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                const Text(
                  '최근 이벤트',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const Spacer(),
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  enableFeedback: false,
                  onPressed: () {
                    eventCountProvider.plus();
                  },
                  child: Row(
                    children: const [
                      Text(
                        '전체보기',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.imagePaths.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventDetailScreen(
                              event: provider.imagePaths[index])),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.asset(
                                    provider.imagePaths[index].imagePath,
                                  )),
                              const SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 4,
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                children: [
                                  Text(
                                    provider.imagePaths[index].address,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    provider.imagePaths[index].date,
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class RecentWitnessView extends StatefulWidget {
  const RecentWitnessView({Key? key}) : super(key: key);

  @override
  State<RecentWitnessView> createState() => _RecentWitnessViewState();
}

class _RecentWitnessViewState extends State<RecentWitnessView> {
  @override
  Widget build(BuildContext context) {
    RecentWitnessProvider provider =
        Provider.of<RecentWitnessProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                const Text(
                  '최근 목격',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text(
                        '전체보기',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.witnesses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      color: Colors.white),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 6,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              provider.witnesses[index].imagePath,
                            )),
                      ),
                      Flexible(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              children: [
                                Text(
                                  provider.witnesses[index].address,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  provider.witnesses[index].date,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
