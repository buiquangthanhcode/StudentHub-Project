import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetService {
  late JitsiMeet jitsiMeet;

  // Private constructor
  JitsiMeetService._() {
    jitsiMeet = JitsiMeet();
  }

  // Singleton instance
  static final JitsiMeetService instance = JitsiMeetService._();

  void join() {
    var options = JitsiMeetConferenceOptions(
      serverURL: 'https://meet.jit.si',
      room: 'KhoaNguyen',
      configOverrides: {
        "startWithAudioMuted":
            false, // Set to false to start with audio enabled.
        "startWithVideoMuted":
            false, // Set to false to start with video enabled.
        "subject": "Jitsi with Flutter",
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
      },
      userInfo: JitsiMeetUserInfo(
          displayName: "Enter your name", email: "engineer@example.com"),
    );
    jitsiMeet.join(options);
  }
}
