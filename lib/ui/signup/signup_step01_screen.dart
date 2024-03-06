import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';
import 'package:studenthub/utils/logger.dart';

import '../../core/text_field_custom.dart';

class SignUpStep01 extends StatefulWidget {
  const SignUpStep01({super.key});

  @override
  State<SignUpStep01> createState() => _SignUpStep01State();
}

class _SignUpStep01State extends State<SignUpStep01> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKeyLogin = GlobalKey<FormBuilderState>();

    List<Map<String, dynamic>> dataSelectedInfor = [
      {
        'image': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH2mWN4-rzaVDVgE6-cml85T4yR5e5MRWqq6yWlhYy4w&s",
        'description': "I am a company,find engineer for project",
        'value': 0,
      },
      {
        'image': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH2mWN4-rzaVDVgE6-cml85T4yR5e5MRWqq6yWlhYy4w&s",
        'description': "I am a student,find engineer for project",
        'value': 0,
      },
    ];

    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: backgroundHeaderAppBar,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NAME_APP,
                style: theme.textTheme.titleMedium,
              ),
              const Icon(Icons.person),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                'Join as company or Student',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: dataSelectedInfor.length,
            itemBuilder: (context, index) {
              final item = dataSelectedInfor[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.smallBoxColor1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            item['image'],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            child: CheckboxListTile(
                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          value: true,
                          onChanged: (value) {},
                        )),
                      ],
                    ),
                    Text(
                      item['description'],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 2,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: theme.colorScheme.smallBoxColor1,
                elevation: 5,
                minimumSize: Size(maxWidth, 40),
              ),
              onPressed: () {
                context.go('/signup_02');
              },
              child: const Text('Create account'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' Already have an account?',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Login',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
