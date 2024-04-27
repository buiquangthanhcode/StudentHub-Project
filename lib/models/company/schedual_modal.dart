import 'dart:convert';

class Schedule {
  String? title;
  String? startTime;
  String? endTime;
  String? projectId;
  String? senderId;
  String? receiverId;
  String? meetingRoomCode;
  String? meetingRoomId;
  String? expiredAt;
  Schedule({
    this.title,
    this.startTime,
    this.endTime,
    this.projectId,
    this.senderId,
    this.receiverId,
    this.meetingRoomCode,
    this.meetingRoomId,
    this.expiredAt,
  });

  Schedule copyWith({
    String? title,
    String? startTime,
    String? endTime,
    String? projectId,
    String? senderId,
    String? receiverId,
    String? meetingRoomCode,
    String? meetingRoomId,
    String? expiredAt,
  }) {
    return Schedule(
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      projectId: projectId ?? this.projectId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      meetingRoomCode: meetingRoomCode ?? this.meetingRoomCode,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      expiredAt: expiredAt ?? this.expiredAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (startTime != null) {
      result.addAll({'startTime': startTime});
    }
    if (endTime != null) {
      result.addAll({'endTime': endTime});
    }
    if (projectId != null) {
      result.addAll({'projectId': projectId});
    }
    if (senderId != null) {
      result.addAll({'senderId': senderId});
    }
    if (receiverId != null) {
      result.addAll({'receiverId': receiverId});
    }
    if (meetingRoomCode != null) {
      result.addAll({'meetingRoomCode': meetingRoomCode});
    }
    if (meetingRoomId != null) {
      result.addAll({'meetingRoomId': meetingRoomId});
    }
    if (expiredAt != null) {
      result.addAll({'expiredAt': expiredAt});
    }

    return result;
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      title: map['title'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      projectId: map['projectId'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      meetingRoomCode: map['meetingRoomCode'],
      meetingRoomId: map['meetingRoomId'],
      expiredAt: map['expiredAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) => Schedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Schedule(title: $title, startTime: $startTime, endTime: $endTime, projectId: $projectId, senderId: $senderId, receiverId: $receiverId, meetingRoomCode: $meetingRoomCode, meetingRoomId: $meetingRoomId, expiredAt: $expiredAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Schedule &&
        other.title == title &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.projectId == projectId &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.meetingRoomCode == meetingRoomCode &&
        other.meetingRoomId == meetingRoomId &&
        other.expiredAt == expiredAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        projectId.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        meetingRoomCode.hashCode ^
        meetingRoomId.hashCode ^
        expiredAt.hashCode;
  }
}
