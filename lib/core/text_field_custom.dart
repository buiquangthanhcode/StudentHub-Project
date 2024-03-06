import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/constants/app_theme.dart';

// Core widget builder for custom TextFormField
class TextFieldFormCustom extends StatelessWidget {
  const TextFieldFormCustom({
    super.key,
    required this.name,
    this.hintText,
    this.icon,
    this.onChange,
    this.onTap,
    this.onSaved,
    this.validator,
    this.maxLines,
    this.initialValue,
    this.focusNode,
    this.textInputType,
    this.textInputAction,
    this.maxLength,
    this.minLines,
    this.onEditingComplete,
    this.onFieldSubmitted,
  });

  final String name;
  final String? hintText;
  final Widget? icon;
  final void Function(String?)? onChange;
  final GestureTapCallback? onTap;
  final void Function(String?)? onSaved;
  final String Function(String?)? validator;
  final int? maxLines;
  final bool obscureText = false;
  final bool autocorrect = true;
  final bool autofocus = false;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType keyboardType = TextInputType.text;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool readOnly = false;
  final bool enabled = true;
  final bool autovalidate = false;
  final bool showCursor = true;
  final bool enableSuggestions = true;
  final bool maxLengthEnforced = false;
  final int? maxLength;
  final int? minLines;
  final bool expands = false;
  final void Function()? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: FormBuilderTextField(
        name: name,
        onChanged: onChange,
        onTap: onTap,
        onSaved: onSaved,
        validator: validator,
        maxLines: maxLines,
        obscureText: obscureText,
        autocorrect: autocorrect,
        autofocus: autofocus,
        initialValue: initialValue,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        textInputAction: textInputAction,
        readOnly: readOnly,
        enabled: enabled,
        showCursor: showCursor,
        enableSuggestions: enableSuggestions,
        maxLength: maxLength,
        minLines: minLines,
        expands: expands,
        onEditingComplete: onEditingComplete,
        onSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox(),
            ],
          ),
          hintText: hintText ?? 'Please select a hint',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.hintColor,
              ),
          contentPadding: const EdgeInsets.all(0),
          // fillColor: Theme.of(context).colorScheme.grey,
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 0,
              color: Color.fromARGB(255, 242, 242, 242),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 0,
              color: Color.fromARGB(255, 242, 242, 242),
            ),
          ),
        ),
      ),
    );
  }
}
