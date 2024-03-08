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
  List<Map<String, dynamic>> dataSelectedInfor = [
    {
      'image':
          "https://banner2.cleanpng.com/20180510/qiw/kisspng-businessperson-management-training-5af42f503fc167.5646384015259523362612.jpg",
      'description': "I am a company,find engineer for project",
      'value': true,
    },
    {
      'image': "https://i.pinimg.com/736x/92/73/08/927308edb73d0d73e86fef57c4a6c1ce.jpg",
      'description': "I am a student,find engineer for project",
      'value': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 242, 242),
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
                          value: item['value'],
                          onChanged: (value) {
                            setState(() {
                              for (var element in dataSelectedInfor) {
                                element['value'] = false;
                              }
                              item['value'] = value;
                            });
                          },
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
                context.push('/signup_02');
              },
              child: const Text('Create account'),
            ),
          ),
          const SizedBox(
            height: 10,
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
              InkWell(
                onTap: () {
                  context.push('/login');
                },
                child: Text(
                  'Login',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
