import 'dart:convert';

class Language {
  int? id;
  String? languageName;
  String? level;
  Language({
    this.id,
    this.languageName,
    this.level,
  });

  Language copyWith({
    int? id,
    String? languageName,
    String? level,
  }) {
    return Language(
      id: id ?? this.id,
      languageName: languageName ?? this.languageName,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (languageName != null) {
      result.addAll({'languageName': languageName});
    }
    if (level != null) {
      result.addAll({'level': level});
    }

    return result;
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['id']?.toInt(),
      languageName: map['languageName'],
      level: map['level'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) => Language.fromMap(json.decode(source));

  @override
  String toString() => 'Language(id: $id, languageName: $languageName, level: $level)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language && other.id == id && other.languageName == languageName && other.level == level;
  }

  @override
  int get hashCode => id.hashCode ^ languageName.hashCode ^ level.hashCode;
}
