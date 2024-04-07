import 'dart:convert';

class Language {
  String? id;
  String? languageName;
  String? level;
  Language({
    this.id,
    required this.languageName,
    required this.level,
  });

  Language copyWith({
    String? languageName,
    String? level,
  }) {
    return Language(
      languageName: languageName ?? this.languageName,
      level: level ?? this.level,
    );
  }

  @override
  String toString() => 'Language(languageName: $languageName, level: $level)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'languageName': languageName});
    result.addAll({'level': level});

    return result;
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      languageName: map['languageName'] ?? '',
      level: map['level'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) => Language.fromMap(json.decode(source));
}
