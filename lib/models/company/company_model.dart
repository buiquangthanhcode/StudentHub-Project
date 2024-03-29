import 'dart:convert';

class Company {
  String? name;
  Company({
    this.name,
  });

  Company copyWith({
    String? name,
  }) {
    return Company(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(json.decode(source));

  @override
  String toString() => 'Company(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
