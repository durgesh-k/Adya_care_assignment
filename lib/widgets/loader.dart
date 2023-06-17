import 'package:adya_care_assignment/utils/constants.dart';
import 'package:flutter/material.dart';

//this basic loader is used wherever a loading animation is needed
class Loader extends StatelessWidget {
  final Color? color;
  const Loader({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(color!),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Personalizing your session ..',
          style:
              TextStyle(fontFamily: 'Medium', fontSize: 16, color: secondary),
        )
      ],
    );
  }
}
