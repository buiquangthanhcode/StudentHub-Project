// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/continue_button.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/describe_input_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/employee_quantity_selection_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/name_input_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/title_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/url_input_widget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class CompanyProfileCreationScreen extends StatefulWidget {
  const CompanyProfileCreationScreen({Key? key}) : super(key: key);

  @override
  State<CompanyProfileCreationScreen> createState() =>
      _CompanyProfileCreationScreenState();
}

class _CompanyProfileCreationScreenState
    extends State<CompanyProfileCreationScreen> {
  final employeeQuantityData = [
    'It\'s just me',
    '2-9',
    '10-99',
    '100-1000',
    'More than 1000',
  ];

  String? radioButtonSelected;
  var employeeQuantity = 0;
  final websiteInputController = TextEditingController();
  final companyNameInputController = TextEditingController();
  final descriptionInputController = TextEditingController();
  bool buttonActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonSelected = employeeQuantityData[0];
  }

  final _formKey = GlobalKey<FormState>();

  void checkFormField() {
    if (websiteInputController.text.isEmpty ||
        companyNameInputController.text.isEmpty ||
        descriptionInputController.text.isEmpty) {
      if (buttonActive) {
        buttonActive = false;
        setState(() {});
      }
    } else {
      if (!buttonActive) {
        buttonActive = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            // title: Text(
            //   'Profile',
            //   style: TextStyle(fontWeight: FontWeight.w500),
            // ),
            // centerTitle: false,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TitleWidget(),
                const SizedBox(height: 60),
                EmployeeQuantitySelectionWidget(
                  chooseEmployeesQuantity: (value) {
                    employeeQuantity = value;
                  },
                ),
                SizedBox(height: 30),
                NameInputWidget(
                    companyNameInputController: companyNameInputController,
                    checkFormField: checkFormField),
                const SizedBox(height: 30),
                UrlInputWidget(
                  websiteInputController: websiteInputController,
                  checkFormField: checkFormField,
                ),
                const SizedBox(height: 30),
                DescribeInputWidget(
                  descriptionInputController: descriptionInputController,
                  checkFormField: checkFormField,
                ),
                const SizedBox(height: 50),
                ContinueButton(
                    buttonActive: true,
                    press: () {
                      // Navigator.pop(context);
                      // context.pushNamed('welcome_screen');
                      if (_formKey.currentState!.validate()) {
                        context.read<CompanyBloc>().add(
                              AddAllDataEvent(
                                  data: Company(
                                    size: 50,
                                    companyName:
                                        companyNameInputController.text,
                                    website: websiteInputController.text,
                                    description:
                                        descriptionInputController.text,
                                  ),
                                  onSuccess: () {
                                    SnackBarService.showSnackBar(
                                        content: 'Successfully!',
                                        status: StatusSnackBar.success);
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.pop(context);
                                    });
                                  }),
                            );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
