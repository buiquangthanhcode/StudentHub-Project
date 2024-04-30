import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoCallPage extends StatelessWidget {
  final String conferenceID;

  const VideoCallPage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = context.read<AuthBloc>().state.userModel;
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID:
            954843811, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            "c243462505dc53b6a3ff53c2a3222146452fc8372d7e181daa1778da55975802", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userModel.id.toString(),
        userName: userModel.fullname ?? '',
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
