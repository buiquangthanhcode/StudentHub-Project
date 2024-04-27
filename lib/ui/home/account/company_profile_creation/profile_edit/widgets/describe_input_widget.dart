import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

class DescribeInputWidget extends StatefulWidget {
  const DescribeInputWidget(
      {Key? key,
      required this.descriptionInputController,
      required this.checkFormField})
      : super(key: key);

  final TextEditingController descriptionInputController;
  final Function() checkFormField;

  @override
  _DescribeInputWidgetState createState() => _DescribeInputWidgetState();
}

class _DescribeInputWidgetState extends State<DescribeInputWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) {
            widget.checkFormField();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          cursorHeight: 18,
          style: textTheme.bodyMedium,
          cursorColor: Colors.black,
          maxLines: 6,
          controller: widget.descriptionInputController,
          decoration: InputDecoration(
            hintText: 'Enter your description...',
            hintStyle: textTheme.bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.hintColor),
            suffixIcon: widget.descriptionInputController.text.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.descriptionInputController.clear();
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
                : Container(
                    width: 1,
                  ),
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
