class Language {
  String name;
  String level;
  Language({
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
}
