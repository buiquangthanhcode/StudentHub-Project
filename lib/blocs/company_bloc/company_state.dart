// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/company/company_model.dart';

class CompanyState extends Equatable {
  final Company company;
  // final Project project;

  const CompanyState({
    required this.company,
    // required this.project,
  });

  @override
  // List<Object?> get props => [company, project];
  List<Object?> get props => [company];

  // CompanyState updateNewCompanyProfle({
  //   Company? company,
  //   Project? project,
  // }) {
  //   return CompanyState(
  //       company: company ?? this.company, project: project ?? this.project);
  // }

  CompanyState updateNewCompanyProfle({
    Company? company,
    Project? project,
  }) {
    return CompanyState(company: company ?? this.company);
  }

  CompanyState update({
    Company? company,
    Project? project,
  }) {
    return CompanyState(
      company: company ?? this.company,
    );
  }
}
