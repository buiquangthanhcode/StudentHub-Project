class Education {
  String nameOfSchool;
  final String timeStart;
  final String timeEnd;
  Education({
    required this.nameOfSchool,
    required this.timeStart,
    required this.timeEnd,
  });

  Education copyWith({
    String? nameOfSchool,
    String? timeStart,
    String? timeEnd,
  }) {
    return Education(
      nameOfSchool: nameOfSchool ?? this.nameOfSchool,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
    );
  }

  @override
  String toString() => 'Education(nameOfSchool: $nameOfSchool, timeStart: $timeStart, timeEnd: $timeEnd)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Education &&
        other.nameOfSchool == nameOfSchool &&
        other.timeStart == timeStart &&
        other.timeEnd == timeEnd;
  }

  @override
  int get hashCode => nameOfSchool.hashCode ^ timeStart.hashCode ^ timeEnd.hashCode;
}
