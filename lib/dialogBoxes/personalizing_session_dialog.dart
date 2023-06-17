import 'package:adya_care_assignment/providers/video_provider.dart';
import 'package:adya_care_assignment/utils/constants.dart';
import 'package:adya_care_assignment/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalizingSessionDialog extends StatelessWidget {
  const PersonalizingSessionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final videoSessionProvider =
        Provider.of<VideoSessionProvider>(context, listen: false);
    videoSessionProvider.setContext(context);

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Loader(color: secondary),
        ));
  }
}
