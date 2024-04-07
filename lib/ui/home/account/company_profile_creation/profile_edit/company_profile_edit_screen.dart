import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
// import 'package:studenthub/blocs/company_bloc/company_create_profile_event.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/save_button.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/describe_input_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/employee_quantity_selection_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/name_input_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/title_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/url_input_widget.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class CompanyProfileEditScreen extends StatefulWidget {
  const CompanyProfileEditScreen({Key? key}) : super(key: key);

  @override
  _PCompanyProfileEditScreenState createState() =>
      _PCompanyProfileEditScreenState();
}

class _PCompanyProfileEditScreenState extends State<CompanyProfileEditScreen> {
  Company? company;
  // ignore: prefer_typing_uninitialized_variables
  int? radioButtonSelected;
  final websiteInputController = TextEditingController();
  final companyNameInputController = TextEditingController();
  final descriptionInputController = TextEditingController();
  bool buttonActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    company = BlocProvider.of<AuthBloc>(context).state.userModel.company!;
    radioButtonSelected = company!.size!;
    websiteInputController.text = company!.website!;
    companyNameInputController.text = company!.companyName!;
    descriptionInputController.text = company!.description!;

    // context.read<CompanyBloc>().add(
    //       GetAllDataEvent(
    //           data: Company(
    //             size: 50,
    //             companyName: companyNameInputController.text,
    //             website: websiteInputController.text,
    //             description: descriptionInputController.text,
    //           ),
    //           onSuccess: () {
    //             SnackBarService.showSnackBar(
    //                 content: 'Successfully!', status: StatusSnackBar.success);
    //             Future.delayed(Duration(seconds: 2), () {
    //               Navigator.pop(context);
    //             });
    //           }),
    //     );
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
        child: AppBar(),
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
                const TitleWidget(),
                const SizedBox(height: 70),
                EmployeeQuantitySelectionWidget(
                  chooseEmployeeQuantity: (value) {
                    radioButtonSelected = value;
                  },
                  value: radioButtonSelected!,
                ),
                const SizedBox(height: 30),
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
                SaveButton(
                    buttonActive: buttonActive,
                    press: () {
                      print(radioButtonSelected);
                      print(companyNameInputController.text);
                      print(websiteInputController.text);
                      print(descriptionInputController.text);
                      if (_formKey.currentState!.validate()) {
                        context.read<CompanyBloc>().add(
                              UpdateAllDataEvent(
                                  data: Company(
                                    size: radioButtonSelected,
                                    companyName:
                                        companyNameInputController.text,
                                    website: websiteInputController.text,
                                    description:
                                        descriptionInputController.text,
                                  ),
                                  id: BlocProvider.of<AuthBloc>(context)
                                      .state
                                      .userModel
                                      .company!
                                      .id!,
                                  onSuccess: () {
                                    SnackBarService.showSnackBar(
                                        content: 'Successfully!',
                                        status: StatusSnackBar.success);
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
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
