class SkillSet {
  String name;
  bool isSelected;
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
}
