import 'dart:convert';

class TechStack {
  final String? description;
  final String? imageUrl;
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? name;

  TechStack(
    this.description,
    this.imageUrl,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  );

  TechStack copyWith({
    String? description,
    String? imageUrl,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? name,
  }) {
    return TechStack(
      description ?? this.description,
      imageUrl ?? this.imageUrl,
      id ?? this.id,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      deletedAt ?? this.deletedAt,
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (description != null) {
      result.addAll({'description': description});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
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
    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory TechStack.fromMap(Map<String, dynamic> map) {
    return TechStack(
      map['description'],
      map['imageUrl'],
      map['id']?.toInt(),
      map['createdAt'],
      map['updatedAt'],
      map['deletedAt'],
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TechStack.fromJson(String source) => TechStack.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TechStack(description: $description, imageUrl: $imageUrl, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TechStack &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.name == name;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        imageUrl.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        name.hashCode;
  }
}
