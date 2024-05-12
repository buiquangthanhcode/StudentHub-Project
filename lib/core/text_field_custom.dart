import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';

// Core widget builder for custom TextFormField
class TextFieldFormCustom extends StatefulWidget {
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
    this.style,
    this.fillColor,
    this.autocorrect,
    this.enableSuggestions,
    this.keyboardType,
    this.autofocus,
    this.obscureText,
    this.isPasswordText,
    this.autovalidateMode,
  });

  final String name;
  final String? hintText;
  final Widget? icon;
  final void Function(String?)? onChange;
  final GestureTapCallback? onTap;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? minLines;
  final void Function()? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final TextStyle? style;
  final Color? fillColor;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? obscureText; // add new
  final bool? isPasswordText;
  final AutovalidateMode? autovalidateMode;

  @override
  State<TextFieldFormCustom> createState() => _TextFieldFormCustomState();
}

class _TextFieldFormCustomState extends State<TextFieldFormCustom> {
  final bool readOnly = false;

  final bool enabled = true;

  final bool autovalidate = false;

  final bool showCursor = true;

  final bool maxLengthEnforced = false;

  final bool expands = false;

  bool isHiddenPassword = false;

  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText ?? false;
    super.initState();
  }

  final _textfieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: FormBuilderTextField(
        key: _textfieldKey,
        name: widget.name,
        onTap: widget.onTap,
        onSaved: widget.onSaved,
        validator: widget.validator,
        maxLines: widget.maxLines ?? 1,
        obscureText: obscureText,
        autovalidateMode: widget.autovalidateMode,
        autocorrect: widget.autocorrect ?? true,
        autofocus: widget.autofocus ?? false,
        initialValue: widget.initialValue ?? '',
        focusNode: widget.focusNode,
        keyboardType: widget.textInputType ?? TextInputType.text,
        textInputAction: widget.textInputAction,
        readOnly: readOnly,
        enabled: enabled,
        showCursor: showCursor,
        enableSuggestions: widget.enableSuggestions ?? true,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        expands: expands,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onFieldSubmitted,
        onChanged: (value) {
          setState(() {
            widget.onChange?.call(value);
          });
        },
        style: widget.style ??
            TextStyle(
              color: Colors.grey[900],
              fontSize: 16,
            ),
        decoration: InputDecoration(
          prefixIcon: widget.maxLines == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.icon ??
                        const SizedBox(
                          width: 0,
                        ),
                  ],
                )
              : null,
          suffixIcon: Builder(builder: (context) {
            if (widget.isPasswordText ?? false) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    isHiddenPassword = !isHiddenPassword;
                    obscureText = !obscureText;
                  });
                },
                // icon: Icon(
                //   isHiddenPassword
                //       ? Icons.visibility
                //       : Icons.visibility_off_rounded,
                // ),
                icon: FaIcon(
                  isHiddenPassword
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  color: Theme.of(context).colorScheme.grey,
                ),
              );
            } else if (_textfieldKey.currentState?.value != '') {
              return IconButton(
                onPressed: () {
                  print("!23");
                  setState(() {
                    _textfieldKey.currentState?.didChange('');
                  });
                },
                icon: Container(
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
              );
            }
            return const SizedBox.shrink();
          }),
          hintText: widget.hintText ?? 'Please select a hint',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.hintColor,
              ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          fillColor:
              widget.fillColor ?? const Color.fromARGB(255, 242, 242, 242),
          filled: true,
          isDense: true,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
        ),
      ),
    );
  }
}
