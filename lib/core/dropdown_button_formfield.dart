import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropDownFormFieldCustom extends StatelessWidget {
  const DropDownFormFieldCustom({
    super.key,
    required this.name,
    required this.data,
    this.onChanged,
    this.onSelected,
    this.onSaved,
    this.hint,
    this.initValue,
  });
  final String name;
  final List<String> data;
  final Function(String)? onChanged;
  final Function(String)? onSelected;
  final Function(String?)? onSaved;
  final String? hint;
  final String? initValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: FormBuilderField<String>(
        name: name,
        builder: (field) {
          return DropdownButtonFormField2<String>(
            isExpanded: true,
            value: initValue,
            decoration: InputDecoration(
              // Add Horizontal padding using menuItemStyleData.padding so it matches
              // the menu padding when button's width is not specified.
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              //validate error
              errorStyle: const TextStyle(color: Colors.redAccent),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // Add more decoration..
            ),
            hint: Text(
              hint ?? 'Select the hint',
              style: const TextStyle(fontSize: 14),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              //Do something when selected item is changed.
              field.didChange(value);
            },
            validator: (value) {
              if (value == null) {
                return 'Please select value.';
              }
              return null;
            },
            items: data
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            onSaved: (value) {
              //Do something when selected item is changed.
              field.didChange(value);
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          );
        },
      ),
    );
  }
}
