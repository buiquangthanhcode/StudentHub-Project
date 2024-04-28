import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/constants/colors.dart';

class DropDownFormFieldCustom<T> extends StatefulWidget {
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
  final List<T> data;
  final Function(T? value)? onChanged;
  final Function(T? value)? onSelected;
  final Function(T? value)? onSaved;
  final String? hint;
  final T? initValue;

  @override
  State<DropDownFormFieldCustom<T>> createState() => _DropDownFormFieldCustomState<T>();
}

class _DropDownFormFieldCustomState<T> extends State<DropDownFormFieldCustom<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: FormBuilderField<T>(
        name: widget.name,
        builder: (field) {
          return DropdownButtonFormField2<T>(
            isExpanded: true,
            value: widget.initValue,
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
              widget.hint ?? 'Select the hint',
              style: const TextStyle(fontSize: 14),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              //Do something when selected item is changed.
              if (value != null) {
                field.didChange(value as T);
                field.save();
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Please select value.';
              }
              return null;
            },
            items: widget.data
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        item.toString(), // [Core][Please override toString method in your model class to show the dropdown item]
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ))
                .toList(),
            onSaved: (value) {
              //Do something when selected item is changed.
              if (value != null) {
                field.didChange(value as T);
                field.save();
                if (widget.onSaved != null) {
                  widget.onSaved!(value);
                }
              }
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: theme.colorScheme.brightness == Brightness.dark ? primaryColor : Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: theme.colorScheme.brightness == Brightness.dark ? Colors.white : Colors.white,
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
