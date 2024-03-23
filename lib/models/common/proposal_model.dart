import 'dart:convert';

enum Status {
  hired,
  hiredOfferSebt,
  notHired,
}

enum DisableFlag {
  enable,
  disable,
}

class Proposal {
  String? id;
  String? projectId;
  String? coverLatter;
  String? status;
  String? disableFlag;
  Proposal({
    this.id,
    this.projectId,
    this.coverLatter,
    this.status,
    this.disableFlag,
  });

  Proposal copyWith({
    String? id,
    String? projectId,
    String? coverLatter,
    String? status,
    String? disableFlag,
  }) {
    return Proposal(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      coverLatter: coverLatter ?? this.coverLatter,
      status: status ?? this.status,
      disableFlag: disableFlag ?? this.disableFlag,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (projectId != null) {
      result.addAll({'projectId': projectId});
    }
    if (coverLatter != null) {
      result.addAll({'coverLatter': coverLatter});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (disableFlag != null) {
      result.addAll({'disableFlag': disableFlag});
    }

    return result;
  }

  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      projectId: map['projectId'],
      coverLatter: map['coverLatter'],
      status: map['status'],
      disableFlag: map['disableFlag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Proposal.fromJson(String source) => Proposal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Proposal(id: $id, projectId: $projectId, coverLatter: $coverLatter, status: $status, disableFlag: $disableFlag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Proposal &&
        other.id == id &&
        other.projectId == projectId &&
        other.coverLatter == coverLatter &&
        other.status == status &&
        other.disableFlag == disableFlag;
  }

  @override
  int get hashCode {
    return id.hashCode ^ projectId.hashCode ^ coverLatter.hashCode ^ status.hashCode ^ disableFlag.hashCode;
  }
}
