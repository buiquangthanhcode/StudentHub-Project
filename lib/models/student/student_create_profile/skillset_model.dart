import 'dart:convert';

class SkillSet {
  final String? name;
  final bool? isSelected;
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  SkillSet({
    this.name,
    this.isSelected,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  SkillSet copyWith({
    String? name,
    bool? isSelected,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return SkillSet(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (isSelected != null) {
      result.addAll({'isSelected': isSelected});
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

    return result;
  }

  factory SkillSet.fromMap(Map<String, dynamic> map) {
    return SkillSet(
      name: map['name'],
      isSelected: map['isSelected'],
      id: map['id']?.toInt(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillSet.fromJson(String source) => SkillSet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SkillSet(name: $name, isSelected: $isSelected, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SkillSet &&
        other.name == name &&
        other.isSelected == isSelected &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        isSelected.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
