// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:studenthub/models/company/company_model.dart';

class CompanyState extends Equatable {
  final Company company;

  CompanyState({
    required this.company,
  });

  @override
  List<Object?> get props => [company];
}
