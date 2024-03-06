// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _DontHaveProfileState();
}

class _DontHaveProfileState extends State<ProfileCreation> {
  final peopleQuantityData = [
    'It\'s just me',
    '2-9 employees',
    '10-99 employees',
    '100-1000 employees',
    'More than 1000 employees',
  ];

  String? radioButtonData;
  final websiteInputController = TextEditingController();
  final companyNameInputController = TextEditingController();
  final descriptionInputController = TextEditingController();
  bool buttonActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonData = peopleQuantityData[0];
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: backgroundHeaderAppBar,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NAME_APP,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Icon(
                Icons.person,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                // const Spacer(),
                Text(
                  'Welcome to Student Hub',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: primarySwatch),
                ),
                // const Spacer(),
                const SizedBox(height: 20),
                const Text(
                    'Tell us about your company and you will be on your way to connect with high-skilled students'),
                // const Spacer(),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How many people are in your company?',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ...peopleQuantityData.map(
                      (e) => SizedBox(
                        height: 36,
                        child: Transform.translate(
                          offset: const Offset(-8, 0),
                          child: RadioListTile<String>(
                            title: Transform.translate(
                              offset: const Offset(-6, 0),
                              child: Text(
                                e,
                                style: radioButtonData == e
                                    ? textTheme.bodyMedium!
                                        .copyWith(color: primarySwatch)
                                    : textTheme.bodyMedium,
                              ),
                            ),
                            activeColor: primarySwatch,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            value: e,
                            groupValue: radioButtonData,
                            onChanged: (String? value) {
                              setState(() {
                                radioButtonData = value!;
                              });
                            },
                            dense: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // const Spacer(),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Company name'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    if (value.length == 1 || value.isEmpty) {
                      setState(() {});
                    }
                    checkFormField();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: companyNameInputController,
                  cursorColor: Colors.black,
                  style: textTheme.bodySmall,
                  decoration: InputDecoration(
                    suffixIcon: companyNameInputController.text.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  companyNameInputController.clear();
                                  checkFormField();
                                  setState(() {});
                                },
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 191, 191, 191),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.xmark,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            width: 1,
                          ),
                    suffixIconConstraints:
                        BoxConstraints(maxHeight: 44, minWidth: 40),
                    hintStyle: Theme.of(context).textTheme.labelSmall,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    fillColor: const Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Website'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1 || value.isEmpty) {
                        setState(() {});
                      }
                      checkFormField();
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !Uri.parse(value).isAbsolute) {
                        return 'Your website address is invalid.';
                      }
                      return null;
                    },
                    controller: websiteInputController,
                    cursorColor: Colors.black,
                    style: textTheme.bodySmall,
                    decoration: InputDecoration(
                      suffixIcon: websiteInputController.text.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    websiteInputController.clear();
                                    checkFormField();
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 191, 191, 191),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              width: 1,
                            ),
                      suffixIconConstraints:
                          BoxConstraints(maxHeight: 44, minWidth: 40),
                      hintStyle: Theme.of(context).textTheme.labelSmall,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      fillColor: const Color.fromARGB(255, 250, 250, 250),
                      filled: true,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 220, 220, 220),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 220, 220, 220),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 220, 220, 220),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Description'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    checkFormField();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  cursorColor: Colors.black,
                  maxLines: 2,
                  controller: descriptionInputController,
                  style: textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.labelSmall,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    fillColor: const Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: buttonActive ? 1 : 0.3,
                      child: ElevatedButton(
                        onPressed: buttonActive
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  print(radioButtonData);
                                  print(companyNameInputController.text);
                                  print(websiteInputController.text);
                                  print(descriptionInputController.text);
                                }
                              }
                            : () {},
                        child: Text(
                          'Continue',
                          style: textTheme.bodyMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
