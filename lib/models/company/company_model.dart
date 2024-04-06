// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Company {
  String? id;
  String? employeeQuantity;
  String? name;
  String? website;
  String? description;

  Company({
    this.id,
    this.employeeQuantity,
    this.name,
    this.website,
    this.description,
  });

  Company copyWith({
    String? id,
    String? employeeQuantity,
    String? name,
    String? website,
    String? description,
  }) {
    return Company(
      id: id ?? this.id,
      employeeQuantity: employeeQuantity ?? this.employeeQuantity,
      name: name ?? this.name,
      website: website ?? this.website,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeQuantity': employeeQuantity,
      'name': name,
      'website': website,
      'description': description,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] != null ? map['id'] as String : null,
      employeeQuantity: map['employeeQuantity'] != null
          ? map['employeeQuantity'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      website: map['website'] != null ? map['website'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Company(id: $id, employeeQuantity: $employeeQuantity, name: $name, website: $website, description: $description)';
  }

  @override
  bool operator ==(covariant Company other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.employeeQuantity == employeeQuantity &&
        other.name == name &&
        other.website == website &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        employeeQuantity.hashCode ^
        name.hashCode ^
        website.hashCode ^
        description.hashCode;
  }
}
