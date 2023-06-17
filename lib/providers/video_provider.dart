import 'dart:io';
import 'package:adya_care_assignment/dialogBoxes/personalizing_session_dialog.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import '../dialogBoxes/emotion_dialog.dart';
import '../dialogBoxes/session_end_dialog.dart';

class VideoSessionProvider extends ChangeNotifier {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  BuildContext? context;

  bool? loading = true;

  //Set the context for dialog boxes
  void setContext(BuildContext context) {
    this.context = context;
  }

  //Getters for video controllers
  VideoPlayerController get videoPlayerController => _videoPlayerController!;
  ChewieController get chewieController => _chewieController!;

  //Initializing video controllers to play video
  VideoSessionProvider() {
    _videoPlayerController =
        VideoPlayerController.asset('assets/images/start.mp4');
    _videoPlayerController!.addListener(() {
      _videoListener();
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      aspectRatio: 9 / 16,
      autoInitialize: true,
      looping: false,
    );
  }

  //Function to create a non-linear video
  void playVideoSegment(String segmentUrl) {
    mergeVideos(segmentUrl).then((outputPath) {
      _videoPlayerController = VideoPlayerController.file(File(outputPath));
      _videoPlayerController!.addListener(() {
        _sessionEndListener();
      });

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        startAt: const Duration(seconds: 15),
        showControls: true,
        autoPlay: true,
        aspectRatio: 9 / 16,
        autoInitialize: true,
        looping: false,
      );
    });
  }

  //Open dialog box when you want to get emotion of the user
  void _videoListener() {
    if (_videoPlayerController!.value.isInitialized) {
      loading = false;
      notifyListeners();
    }
    if (_videoPlayerController!.value.position ==
        _videoPlayerController!.value.duration) {
      showAnimatedDialog(
        context: context!,
        animationType: DialogTransitionType.scale,
        builder: (BuildContext context) {
          return const EmotionDialog();
        },
      );
    }
  }

  //Open dialog box when session gets ended
  void _sessionEndListener() {
    if (_videoPlayerController!.value.position ==
        _videoPlayerController!.value.duration) {
      showAnimatedDialog(
        context: context!,
        animationType: DialogTransitionType.scale,
        builder: (BuildContext context) {
          return const SessionEndDialog();
        },
      );
    }
  }

  //Function to create non-linear video
  Future<String> mergeVideos(String? path) async {
    loading = true;
    notifyListeners();

    //Getting storage permission from the user
    await Permission.storage.request();

    //Initialising ffmpeg to create session
    final FlutterFFmpeg ffmpeg = FlutterFFmpeg();

    //Creating temporary storage to store current session
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    //creating temporary storage for first video
    final String video1Path = "$tempPath/video1.mp4";
    final ByteData video1Bytes =
        await rootBundle.load('assets/images/start.mp4');
    final File video1File = File('$tempPath/video1.mp4');
    await video1File.writeAsBytes(video1Bytes.buffer.asUint8List());

    //creating temporary storage for first video
    final String video2Path = "$tempPath/video2.mp4";
    final ByteData video2Bytes = await rootBundle.load(path!);
    final File video2File = File('$tempPath/video2.mp4');
    await video2File.writeAsBytes(video2Bytes.buffer.asUint8List());

    //non-linear video created for session
    String mergedVideoPath = "$tempPath/merged_video.mp4";

    //delete existing session if available
    final File mergedVideoFile = File(mergedVideoPath);
    if (await mergedVideoFile.exists()) {
      await mergedVideoFile.delete();
    }

    //command to create a non-linear video
    final String mergeCommand =
        '-i $video1Path -i $video2Path -filter_complex "[0:v]scale=360:450,setsar=1,pad=ceil(iw/2)*2:ceil(ih/2)*2[v0];[1:v]scale=360:450,setsar=1,pad=ceil(iw/2)*2:ceil(ih/2)*2[v1];[v0][v1]concat=n=2:v=1:a=0[v]" -map "[v]" -r 30 -vsync 2 $mergedVideoPath';

    //Show a loader for session
    Navigator.pop(context!);
    showAnimatedDialog(
      context: context!,
      animationType: DialogTransitionType.scale,
      builder: (BuildContext context) {
        return const PersonalizingSessionDialog();
      },
    );

    //Execute command to create a non-linear video
    await ffmpeg.execute(mergeCommand);

    //Close the dialogbox
    loading = false;
    Navigator.pop(context!);

    notifyListeners();
    return mergedVideoPath;
  }
}
