import 'dart:convert';

class RequestProjectProposal {
  final String? projectId;
  final String? q;
  final int? offset;
  final int? limit;
  final String? order;
  final int? statusFlag;
  RequestProjectProposal({
    this.projectId,
    this.q,
    this.offset,
    this.limit,
    this.order,
    this.statusFlag,
  });

  RequestProjectProposal copyWith({
    String? projectId,
    String? q,
    int? offset,
    int? limit,
    String? order,
    int? statusFlag,
  }) {
    return RequestProjectProposal(
      projectId: projectId ?? this.projectId,
      q: q ?? this.q,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      order: order ?? this.order,
      statusFlag: statusFlag ?? this.statusFlag,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (projectId != null) {
      result.addAll({'projectId': projectId});
    }
    if (q != null) {
      result.addAll({'q': q});
    }
    if (offset != null) {
      result.addAll({'offset': offset});
    }
    if (limit != null) {
      result.addAll({'limit': limit});
    }
    if (order != null) {
      result.addAll({'order': order});
    }
    if (statusFlag != null) {
      result.addAll({'statusFlag': statusFlag});
    }

    return result;
  }

  factory RequestProjectProposal.fromMap(Map<String, dynamic> map) {
    return RequestProjectProposal(
      projectId: map['projectId'],
      q: map['q'],
      offset: map['offset']?.toInt(),
      limit: map['limit']?.toInt(),
      order: map['order'],
      statusFlag: map['statusFlag']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestProjectProposal.fromJson(String source) => RequestProjectProposal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestProjectProposal(projectId: $projectId, q: $q, offset: $offset, limit: $limit, order: $order, statusFlag: $statusFlag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestProjectProposal &&
        other.projectId == projectId &&
        other.q == q &&
        other.offset == offset &&
        other.limit == limit &&
        other.order == order &&
        other.statusFlag == statusFlag;
  }

  @override
  int get hashCode {
    return projectId.hashCode ^ q.hashCode ^ offset.hashCode ^ limit.hashCode ^ order.hashCode ^ statusFlag.hashCode;
  }
}
