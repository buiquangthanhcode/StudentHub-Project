import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/student_profile_creation_step_3/student_profile_creation_step_3_screen.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({
    super.key,
    required this.file,
    this.isOpen = false,
  });

  final FileModel file;
  final bool isOpen;

  @override
  // ignore: library_private_types_in_public_api
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  int progress = 0;

  void startDownloading() async {
    String path = await _getFilePath(widget.file.name ?? '');

    await dio.download(
      widget.file.url ?? '',
      path,
      options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes;
        });
      },
    ).then((_) async {
      Navigator.pop(context);
      if (widget.isOpen) {
        OpenFile.open(path);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      Navigator.pop(context);
      EasyLoading.dismiss();
      SnackBarService.showSnackBar(
        content: 'Tải thất bại',
        status: StatusSnackBar.error,
      );
    });
  }

  Future<String> _getFilePath(String filename) async {
    Directory dir;
    // final dir = await getTemporaryDirectory();
    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      String directory = '/storage/emulated/0/Download/';
      var dirDownloadExists = true;
      dirDownloadExists = await Directory(directory).exists();
      if (!dirDownloadExists) {
        directory = '/storage/emulated/0/Downloads/';
        dirDownloadExists = await Directory(directory).exists();
        if (!dirDownloadExists) {
          directory = (await getTemporaryDirectory()).path;
        }
      }
      dir = Directory(directory);
    }
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String downloadingprogress = (progress * 100).toStringAsFixed(0);

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            value: progress.toDouble(),
            color: primaryColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $progress KB",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
