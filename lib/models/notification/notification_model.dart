import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/common/proposal_modal.dart';

class NotificationModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? receiverId;
  int? senderId;
  int? messageId;
  String? title;
  String? notifyFlag;
  String? typeNotifyFlag;
  String? content;
  Message? message;
  Participant? sender;
  Participant? receiver;
  Interview? interview;
  MeetingRoom? meetingRoom;
  Proposal? proposal;

  NotificationModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.receiverId,
      this.senderId,
      this.messageId,
      this.title,
      this.notifyFlag,
      this.typeNotifyFlag,
      this.content,
      this.message,
      this.sender,
      this.receiver,
      this.interview,
      this.meetingRoom,
      this.proposal});

  NotificationModel copyWith(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? deletedAt,
      int? receiverId,
      int? senderId,
      int? messageId,
      String? title,
      String? notifyFlag,
      String? typeNotifyFlag,
      String? content,
      Message? message,
      Participant? sender,
      Participant? receiver,
      Interview? interview,
      MeetingRoom? meetingRoom,
      Proposal? proposal}) {
    return NotificationModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        receiverId: receiverId ?? this.receiverId,
        senderId: senderId ?? this.senderId,
        messageId: messageId ?? this.messageId,
        title: title ?? this.title,
        notifyFlag: notifyFlag ?? this.notifyFlag,
        typeNotifyFlag: typeNotifyFlag ?? this.typeNotifyFlag,
        content: content ?? this.content,
        message: message ?? this.message,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        interview: interview ?? this.interview,
        meetingRoom: meetingRoom ?? this.meetingRoom,
        proposal: proposal ?? this.proposal);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (deletedAt != null) {
      result.addAll({'deletedAt': deletedAt});
    }
    if (receiverId != null) {
      result.addAll({'receiverId': receiverId});
    }
    if (senderId != null) {
      result.addAll({'senderId': senderId});
    }
    if (messageId != null) {
      result.addAll({'messageId': messageId});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (notifyFlag != null) {
      result.addAll({'notifyFlag': notifyFlag});
    }
    if (typeNotifyFlag != null) {
      result.addAll({'typeNotifyFlag': typeNotifyFlag});
    }
    if (content != null) {
      result.addAll({'content': content});
    }
    if (message != null) {
      result.addAll({'message': message!.toMap()});
    }
    if (sender != null) {
      result.addAll({'sender': sender!.toMap()});
    }
    if (receiver != null) {
      result.addAll({'receiver': receiver!.toMap()});
    }
    if (interview != null) {
      result.addAll({'interview': interview!.toMap()});
    }
    if (meetingRoom != null) {
      result.addAll({'meetingRoom': meetingRoom});
    }
    if (proposal != null) {
      result.addAll({'proposal': proposal});
    }

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toInt(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      receiverId: map['receiverId']?.toInt(),
      senderId: map['senderId']?.toInt(),
      messageId: map['messageId']?.toInt(),
      title: map['title'],
      notifyFlag: map['notifyFlag'],
      typeNotifyFlag: map['typeNotifyFlag'],
      content: map['content'],
      message: map['message'] != null ? Message.fromMap(map['message']) : null,
      sender: map['sender'] != null ? Participant.fromMap(map['sender']) : null,
      receiver: map['receiver'] != null ? Participant.fromMap(map['receiver']) : null,
      interview: map['interview'] != null ? Interview.fromMap(map['interview']) : null,
      meetingRoom: map['meetingRoom'] != null ? MeetingRoom.fromMap(map['meetingRoom']) : null,
      proposal: map['proposal'] != null ? Proposal.fromMap(map['proposal']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, receiverId: $receiverId, senderId: $senderId, messageId: $messageId, title: $title, notifyFlag: $notifyFlag, typeNotifyFlag: $typeNotifyFlag, content: $content, message: $message, sender: $sender, receiver: $receiver, interview: $interview, meetingRoom: $meetingRoom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.receiverId == receiverId &&
        other.senderId == senderId &&
        other.messageId == messageId &&
        other.title == title &&
        other.notifyFlag == notifyFlag &&
        other.typeNotifyFlag == typeNotifyFlag &&
        other.content == content &&
        other.message == message &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.interview == interview &&
        other.meetingRoom == meetingRoom;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        receiverId.hashCode ^
        senderId.hashCode ^
        messageId.hashCode ^
        title.hashCode ^
        notifyFlag.hashCode ^
        typeNotifyFlag.hashCode ^
        content.hashCode ^
        message.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        interview.hashCode ^
        meetingRoom.hashCode;
  }
}

class Participant {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? email;
  String? fullname;
  List<int>? roles;
  bool? verified;
  bool? isConfirmed;
  Participant({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.email,
    this.fullname,
    this.roles,
    this.verified,
    this.isConfirmed,
  });

  Participant copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? email,
    String? fullname,
    List<int>? roles,
    bool? verified,
    bool? isConfirmed,
  }) {
    return Participant(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      roles: roles ?? this.roles,
      verified: verified ?? this.verified,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (deletedAt != null) {
      result.addAll({'deletedAt': deletedAt});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (fullname != null) {
      result.addAll({'fullname': fullname});
    }
    if (roles != null) {
      result.addAll({'roles': roles});
    }
    if (verified != null) {
      result.addAll({'verified': verified});
    }
    if (isConfirmed != null) {
      result.addAll({'isConfirmed': isConfirmed});
    }

    return result;
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      id: map['id']?.toInt(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      email: map['email'],
      fullname: map['fullname'],
      roles: List<int>.from(map['roles'] ?? []),
      verified: map['verified'],
      isConfirmed: map['isConfirmed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Participant.fromJson(String source) => Participant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Participant(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, email: $email, fullname: $fullname, roles: $roles, verified: $verified, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Participant &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.email == email &&
        other.fullname == fullname &&
        listEquals(other.roles, roles) &&
        other.verified == verified &&
        other.isConfirmed == isConfirmed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        email.hashCode ^
        fullname.hashCode ^
        roles.hashCode ^
        verified.hashCode ^
        isConfirmed.hashCode;
  }
}

class MeetingRoom {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? meetingRoomCode;
  String? meetingRoomId;
  String? expiredAt;
  MeetingRoom({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.meetingRoomCode,
    this.meetingRoomId,
    this.expiredAt,
  });

  MeetingRoom copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? meetingRoomCode,
    String? meetingRoomId,
    String? expiredAt,
  }) {
    return MeetingRoom(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      meetingRoomCode: meetingRoomCode ?? this.meetingRoomCode,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      expiredAt: expiredAt ?? this.expiredAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (deletedAt != null) {
      result.addAll({'deletedAt': deletedAt});
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

  factory MeetingRoom.fromMap(Map<String, dynamic> map) {
    return MeetingRoom(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      meetingRoomCode: map['meetingRoomCode'],
      meetingRoomId: map['meetingRoomId'],
      expiredAt: map['expiredAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetingRoom.fromJson(String source) => MeetingRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MeetingRoom(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, meetingRoomCode: $meetingRoomCode, meetingRoomId: $meetingRoomId, expiredAt: $expiredAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MeetingRoom &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.meetingRoomCode == meetingRoomCode &&
        other.meetingRoomId == meetingRoomId &&
        other.expiredAt == expiredAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        meetingRoomCode.hashCode ^
        meetingRoomId.hashCode ^
        expiredAt.hashCode;
  }
}
