import 'dart:convert';

class Request {
  String? name;
  Request({
    this.name,
  });

  Request copyWith({
    String? name,
  }) {
    return Request(
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

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) => Request.fromMap(json.decode(source));

  @override
  String toString() => 'Request(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Request && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
