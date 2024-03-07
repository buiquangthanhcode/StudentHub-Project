// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/continue_button.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/describe_input_widget.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/employee_quantity_selection_widget.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/name_input_widget.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/title_widget.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/url_input_widget.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _DontHaveProfileState();
}

class _DontHaveProfileState extends State<ProfileCreation> {
  final employeeQuantityData = [
    'It\'s just me',
    '2-9',
    '10-99',
    '100-1000',
    'More than 1000',
  ];

  String? radioButtonSelected;
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
          leading: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
          ),
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
                EmployeeQuantitySelectionWidget(),
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
                    buttonActive: buttonActive,
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        print(radioButtonSelected);
                        print(companyNameInputController.text);
                        print(websiteInputController.text);
                        print(descriptionInputController.text);
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
