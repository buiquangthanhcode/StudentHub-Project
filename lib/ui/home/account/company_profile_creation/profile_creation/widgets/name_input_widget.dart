import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';

class NameInputWidget extends StatefulWidget {
  const NameInputWidget(
      {super.key,
      required this.companyNameInputController,
      required this.checkFormField});

  final TextEditingController companyNameInputController;
  final Function() checkFormField;

  @override
  _NameInputWidgetState createState() => _NameInputWidgetState();
}

class _NameInputWidgetState extends State<NameInputWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              // 'What is the name of your company?',
              whatIsNameOfCompanyMsgKey.tr(),
              style: textTheme.bodySmall,
            ),
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
            widget.checkFormField();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          cursorHeight: 18,
          controller: widget.companyNameInputController,
          cursorColor: Colors.black,
          style: textTheme.bodyMedium!.copyWith(color: Colors.black),
          decoration: InputDecoration(
            // hintText: 'Enter your company name...',
            hintText: enterYourCompanyPlaceHolderKey.tr(),
            hintStyle: textTheme.bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.hintColor),
            suffixIcon: widget.companyNameInputController.text.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.companyNameInputController.clear();
                          widget.checkFormField();
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
                : Container(width: 1),
            suffixIconConstraints: const BoxConstraints(minWidth: 50),
            contentPadding: const EdgeInsets.all(15),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            errorStyle: const TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            disabledBorder: defaultInputBorder,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: defaultInputBorder,
          ),
        ),
      ],
    );
  }
}
