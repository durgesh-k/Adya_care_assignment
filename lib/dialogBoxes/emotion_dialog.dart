import 'package:adya_care_assignment/providers/video_provider.dart';
import 'package:adya_care_assignment/utils/constants.dart';
import 'package:adya_care_assignment/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmotionDialog extends StatelessWidget {
  const EmotionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final videoSessionProvider =
        Provider.of<VideoSessionProvider>(context, listen: false);
    videoSessionProvider.setContext(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: videoSessionProvider.loading!
          ? Loader(color: secondary)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getWidth(context),
                  color: secondary.withOpacity(0.06),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      'Choose an Emotion',
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 20,
                          color: secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          videoSessionProvider
                              .playVideoSegment(emotionsUrl['happy']!);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              '😀',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          videoSessionProvider
                              .playVideoSegment(emotionsUrl['sad']!);
                          //Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              '😞',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          videoSessionProvider
                              .playVideoSegment(emotionsUrl['angry']!);
                          //Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              '😠',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          videoSessionProvider
                              .playVideoSegment(emotionsUrl['relaxed']!);
                          //Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              '😌',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
