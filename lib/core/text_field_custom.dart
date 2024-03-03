import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFieldFormCustom extends StatelessWidget {
  const TextFieldFormCustom({super.key, required this.name, this.hintText, this.icon});

  final String name;
  final String? hintText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox(),
            ],
          ),
          hintText: hintText ?? 'Please select a hint',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          contentPadding: const EdgeInsets.all(0),
          fillColor: Theme.of(context).primaryColor,
          filled: true,
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 242, 242, 242),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 242, 242, 242),
            ),
          ),
        ),
      ),
    );
  }
}
