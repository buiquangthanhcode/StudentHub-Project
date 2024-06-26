import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
// import 'package:studenthub/blocs/company_bloc/company_create_profile_event.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/save_button.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/describe_input_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/employee_quantity_selection_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/name_input_widget.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_edit/widgets/url_input_widget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class CompanyProfileEditScreen extends StatefulWidget {
  const CompanyProfileEditScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    super.initState();
    company = BlocProvider.of<AuthBloc>(context).state.userModel.company!;
    radioButtonSelected = company!.size! > 4
        ? 4
        : company!.size! < 0
            ? 0
            : company!.size!;
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
    return BlocBuilder<AuthBloc, AuthenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: Text(
                // 'Edit Profile',
                editProfileTitleKey.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
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
                    const SizedBox(height: 24),
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
                    // const Spacer(),
                    SaveButton(
                        buttonActive: buttonActive,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            int id = BlocProvider.of<AuthBloc>(context)
                                .state
                                .userModel
                                .company!
                                .id!;
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
                                      id: id,
                                      onSuccess: (Company company) {
                                        context.read<AuthBloc>().add(
                                            UpdateInformationEvent(
                                                userModel: state.userModel
                                                    .copyWith(
                                                        company: company)));
                                        SnackBarService.showSnackBar(
                                            // content: 'Successfully!',
                                            content: changeSuccessMsgKey.tr(),
                                            status: StatusSnackBar.success);
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Navigator.pop(context);
                                        });
                                      }),
                                );
                          }
                        }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
