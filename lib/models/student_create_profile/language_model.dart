import 'dart:convert';

class Language {
  String? id;
  String? name;
  String? level;
  Language({
    this.id,
    required this.name,
    required this.level,
  });

  Language copyWith({
    String? name,
    String? level,
  }) {
    return Language(
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  @override
  String toString() => 'Language(name: $name, level: $level)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'level': level});

    return result;
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      name: map['name'] ?? '',
      level: map['level'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) => Language.fromMap(json.decode(source));
}
