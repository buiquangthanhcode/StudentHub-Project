import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';

class SignUpStep01Screen extends StatefulWidget {
  const SignUpStep01Screen({super.key});

  @override
  State<SignUpStep01Screen> createState() => _SignUpStep01State();
}

class _SignUpStep01State extends State<SignUpStep01Screen> {
  List<Map<String, dynamic>> dataSelectedInfor = [
    {
      'image': "lib/assets/images/company.png",
      // 'description': "I am a company, find engineer for project",
      'description': registerForCompanyKey.tr(),
      'value': true,
    },
    {
      'image': "lib/assets/images/student.png",
      // 'description': "I am a student, find project for learning",
      'description': registerForStudentKey.tr(),
      'value': false,
    },
  ];

  bool isCompany = true; // true for company, false1 for student

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text.rich(
                  TextSpan(
                    // text: 'Let\'s register  \n',
                    text: letRegisterKey.tr(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    children: [
                      TextSpan(
                        // text: 'Account',
                        text: accountKey.tr(),
                        style: const TextStyle(
                          color:
                              primaryColor, // Replace with your desired color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  // 'Create your own account to process next step',
                  registerDescriptionKey.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataSelectedInfor.length,
                itemBuilder: (context, index) {
                  final item = dataSelectedInfor[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.colorScheme.grey!,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              item['image'],
                              height: 60,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                                child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.black,
                              ),
                              child: Transform.scale(
                                scale: 1.1,
                                child: CheckboxListTile(
                                  activeColor: primaryColor,
                                  visualDensity: VisualDensity.compact,
                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  value: item['value'],
                                  onChanged: (value) {
                                    for (int i = 0;
                                        i < dataSelectedInfor.length;
                                        i++) {
                                      if (i != index) {
                                        dataSelectedInfor[i]['value'] = false;
                                      }
                                    }
                                    item['value'] = true;
                                    isCompany = !isCompany;
                                    setState(() {});
                                  },
                                ),
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(item['description'],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
              ),
              // const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: Size(maxWidth, 56),
                  ),
                  onPressed: () {
                    isCompany
                        ? context.pushNamed('signup_02_for_company',
                            queryParameters: {'role': isCompany ? '1' : '0'})
                        : context.pushNamed('signup_02_for_student',
                            queryParameters: {'role': isCompany ? '1' : '0'});
                  },
                  child: Text(
                    // 'Create account',
                    createAccountBtnKey.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // 'Already have an account? ',
                    alreadyHaveAccountKey.tr(),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/login');
                    },
                    child: Text(
                      // 'Login',
                      loginBtnKey.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
