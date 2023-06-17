import 'package:adya_care_assignment/providers/video_provider.dart';
import 'package:adya_care_assignment/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionEndDialog extends StatelessWidget {
  const SessionEndDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final videoSessionProvider =
        Provider.of<VideoSessionProvider>(context, listen: false);
    videoSessionProvider.setContext(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: getWidth(context),
            color: secondary.withOpacity(0.06),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                '🎉 Congratulations !',
                style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 20,
                    color: secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You have completed your session',
                    style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16,
                      color: secondary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: primary),
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
