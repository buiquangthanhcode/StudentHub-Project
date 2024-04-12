import 'dart:convert';

class Resume {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? link;
  int? userId;
  int? teckStackId;
  String? resume;
  Resume({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.link,
    this.userId,
    this.teckStackId,
    this.resume,
  });

  Resume copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? title,
    String? description,
    String? link,
    int? userId,
    int? teckStackId,
    String? resume,
  }) {
    return Resume(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
      userId: userId ?? this.userId,
      teckStackId: teckStackId ?? this.teckStackId,
      resume: resume ?? this.resume,
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
    if (title != null) {
      result.addAll({'title': title});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (link != null) {
      result.addAll({'link': link});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (teckStackId != null) {
      result.addAll({'teckStackId': teckStackId});
    }
    if (resume != null) {
      result.addAll({'resume': resume});
    }

    return result;
  }

  factory Resume.fromMap(Map<String, dynamic> map) {
    return Resume(
      id: map['id']?.toInt(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      title: map['title'],
      description: map['description'],
      link: map['link'],
      userId: map['userId']?.toInt(),
      teckStackId: map['teckStackId']?.toInt(),
      resume: map['resume'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Resume.fromJson(String source) => Resume.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Resume(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, description: $description, link: $link, userId: $userId, teckStackId: $teckStackId, resume: $resume)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Resume &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.title == title &&
        other.description == description &&
        other.link == link &&
        other.userId == userId &&
        other.teckStackId == teckStackId &&
        other.resume == resume;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        title.hashCode ^
        description.hashCode ^
        link.hashCode ^
        userId.hashCode ^
        teckStackId.hashCode ^
        resume.hashCode;
  }
}
