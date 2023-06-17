import 'package:adya_care_assignment/providers/video_provider.dart';
import 'package:adya_care_assignment/utils/constants.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<VideoSessionProvider>(
        builder: (context, videoSessionProvider, child) {
          videoSessionProvider.setContext(context);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Logo
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: getHeight(context) * 0.05,
                        fit: BoxFit.contain,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adya.Care',
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                color: secondary,
                                fontSize: 24),
                          ),
                          Text(
                            'Feel Human Again !',
                            style: TextStyle(
                                fontFamily: 'Medium',
                                color: secondary,
                                fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  //Video Player
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.grey.withOpacity(0.2),
                        child: Chewie(
                          controller: videoSessionProvider.chewieController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Extra Info
                  Text(
                    'Get your personalized therapeutic session now with Adya.Care !',
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 20, color: secondary),
                  ),
                  Text(
                    '( Play the video to start the session )',
                    style: TextStyle(
                        fontFamily: 'Medium', fontSize: 14, color: secondary),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
