import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movies_app/utilis/all_colors.dart';
import 'package:movies_app/utilis/all_text.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:path/path.dart' as path;

class ChooseDownloadScreen extends StatefulWidget {
  final String videoUrl;

  const ChooseDownloadScreen({super.key, required this.videoUrl});

  @override
  State<ChooseDownloadScreen> createState() => _ChooseDownloadScreenState();
}

class _ChooseDownloadScreenState extends State<ChooseDownloadScreen> {


String percent='0';
  downloadVideoWithDio(String url)async{
    Dio dio=Dio();
    var dir=await getApplicationDocumentsDirectory();
    final status=await Permission.storage.request();
    try{
      if(status.isGranted){
        final res=await dio.download(url,'${dir.path}/${path.basename(url)}',onReceiveProgress: (rec,total){
           percent='${((rec/total)*100).toStringAsFixed(0)}%';

          setState(() {

          });
        });
        if(res.statusCode==200||res.statusCode==201){

          OpenFile.open('${dir.path}/${path.basename(url)}');

        }
      }

        }catch(e){
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AllColors.primaryBackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async{
                  downloadVideoWithDio('https://media.istockphoto.com/id/836470700/video/rain-clouds.mp4?s=mp4-640x640-is&k=20&c=qsD_Otvqq8PD8AgpSsTMTjnLGzXhMeb7AypOOFWt5BY=');
                },
                child: const Text('download')),
            Text(
              'Percent $percent',
              style: customStyle.copyWith(color: Colors.white, fontSize: 56),
            ),
          ],
        ),
      ),
    ));
  }
}

void _saveVideo(File videoFile, String videoTitle) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final savePath = '${appDocDir.path}/$videoTitle.mp4';

  final videoBytes = await videoFile.readAsBytes();
  final File file = File(savePath);

  await file.writeAsBytes(videoBytes);

  // Show a success message or handle errors here
}

