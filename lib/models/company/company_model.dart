// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Company {
  int? id;
  int? userId;
  int? size;
  String? companyName;
  String? website;
  String? description;
  String? updatedAt;
  String? deletedAt;
  String? createAt;
  Company({
    this.id,
    this.userId,
    this.size,
    this.companyName,
    this.website,
    this.description,
    this.updatedAt,
    this.deletedAt,
    this.createAt,
  });

  Company copyWith({
    int? id,
    int? userId,
    int? size,
    String? companyName,
    String? website,
    String? description,
    String? updatedAt,
    String? deletedAt,
    String? createAt,
  }) {
    return Company(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      size: size ?? this.size,
      companyName: companyName ?? this.companyName,
      website: website ?? this.website,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'size': size,
      'companyName': companyName,
      'website': website,
      'description': description,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'createAt': createAt,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? 0,
      size: map['size'] ?? 0,
      companyName: map['companyName'] ?? '',
      website: map['website'] ?? '',
      description: map['description'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      deletedAt: map['deletedAt'] ?? '',
      createAt: map['createAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company(id: $id, userId: $userId, size: $size, companyName: $companyName, website: $website, description: $description, updatedAt: $updatedAt, deletedAt: $deletedAt, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant Company other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.size == size &&
        other.companyName == companyName &&
        other.website == website &&
        other.description == description &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        size.hashCode ^
        companyName.hashCode ^
        website.hashCode ^
        description.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        createAt.hashCode;
  }
}
