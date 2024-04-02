import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

class SignUpStep01Screen extends StatefulWidget {
  const SignUpStep01Screen({super.key});

  @override
  State<SignUpStep01Screen> createState() => _SignUpStep01State();
}

class _SignUpStep01State extends State<SignUpStep01Screen> {
  List<Map<String, dynamic>> dataSelectedInfor = [
    {
      'image': "lib/assets/images/company.png",
      'description': "I am a company, find engineer for project",
      'value': true,
    },
    {
      'image': "lib/assets/images/student.png",
      'description': "I am a student, find project for learning",
      'value': false,
    },
  ];

  bool choice = true; // true for company, false1 for student

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          // title: Container(
          //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //   child: const Center(
          //     child: SizedBox(),
          //   ),
          // ),
          ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text.rich(
                TextSpan(
                  text: 'Let\'s register  \n',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Account',
                      style: TextStyle(
                        color: primaryColor, // Replace with your desired color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'Create your own account to process next step',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
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
                                  setState(() {
                                    for (var element in dataSelectedInfor) {
                                      element['value'] = false;
                                    }
                                    item['value'] = value;
                                    choice = !choice;
                                  });
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
                  choice
                      ? context.pushNamed('signup_02_for_company')
                      : context.pushNamed('signup_02_for_student');
                },
                child: Text(
                  'Create account',
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
                  'Already have an account? ',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push('/login');
                  },
                  child: Text(
                    'Login',
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
    );
  }
}
