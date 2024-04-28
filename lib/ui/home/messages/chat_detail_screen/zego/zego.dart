import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = context.read<AuthBloc>().state.userModel;

    return ZegoUIKitPrebuiltCall(
      appID:
          672017939, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '423952e6560a7b704410b469a73a18db4d0a93c7c0d3729b971efd2eb556dbdc', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userModel.id.toString(),
      userName: userModel.fullname ?? '',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
