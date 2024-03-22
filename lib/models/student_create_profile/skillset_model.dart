import 'dart:convert';

class SkillSet {
  String? name;
  bool? isSelected;
  SkillSet({
    required this.name,
    required this.isSelected,
  });

  @override
  String toString() => 'SkillSet(name: $name, isSelected: $isSelected)';

  SkillSet copyWith({
    String? name,
    bool? isSelected,
  }) {
    return SkillSet(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'isSelected': isSelected});

    return result;
  }

  factory SkillSet.fromMap(Map<String, dynamic> map) {
    return SkillSet(
      name: map['name'] ?? '',
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillSet.fromJson(String source) => SkillSet.fromMap(json.decode(source));
}
