// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Interview {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? title;
  String? startTime;
  String? endTimel;
  String? disableFlag;
  Interview({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.startTime,
    this.endTimel,
    this.disableFlag,
  });

  Interview copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? title,
    String? startTime,
    String? endTimel,
    String? disableFlag,
  }) {
    return Interview(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTimel: endTimel ?? this.endTimel,
      disableFlag: disableFlag ?? this.disableFlag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'title': title,
      'startTime': startTime,
      'endTimel': endTimel,
      'disableFlag': disableFlag,
    };
  }

  factory Interview.fromMap(Map<String, dynamic> map) {
    return Interview(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTimel: map['endTimel'] != null ? map['endTimel'] as String : null,
      disableFlag: map['disableFlag'] != null ? map['disableFlag'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Interview.fromJson(String source) => Interview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Interview(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, title: $title, startTime: $startTime, endTimel: $endTimel, disableFlag: $disableFlag)';
  }

  @override
  bool operator ==(covariant Interview other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.deletedAt == deletedAt &&
      other.title == title &&
      other.startTime == startTime &&
      other.endTimel == endTimel &&
      other.disableFlag == disableFlag;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode ^
      title.hashCode ^
      startTime.hashCode ^
      endTimel.hashCode ^
      disableFlag.hashCode;
  }
}
