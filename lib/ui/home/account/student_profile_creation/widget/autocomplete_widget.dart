import 'package:flutter/material.dart';
import 'package:studenthub/utils/logger.dart';

class AutoCompleteWidget extends StatefulWidget {
  const AutoCompleteWidget({
    super.key,
    required this.data,
    this.onSelected,
  });

  final List<String> data;
  final Function(String value)? onSelected;

  @override
  State<AutoCompleteWidget> createState() => _AutoCompleteWidgetState();
}

class _AutoCompleteWidgetState extends State<AutoCompleteWidget> {
  late TextEditingController textEditingController;
  final GlobalKey _autocompleteKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return RawAutocomplete<String>(
          key: _autocompleteKey,
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  height: options.length <= 2 ? 100 : 200,
                  width: constraints.biggest.width,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                            title: Text(
                          option,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          ),
                        )),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          displayStringForOption: (option) {
            return option;
          },
          fieldViewBuilder: (context, fieldTextEditingController, focusNode, onFieldSubmitted) {
            textEditingController = fieldTextEditingController;
            return TextFormField(
              controller: fieldTextEditingController,
              focusNode: focusNode,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 16,
              ),
              scrollPadding: const EdgeInsets.all(0),
              decoration: const InputDecoration(
                // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                isDense: true,
                hintText: 'Enter your skill',
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
              ),
            );
          },
          optionsBuilder: (TextEditingValue skillsetTextEditController) {
            if (skillsetTextEditController.text == '') {
              return const Iterable<String>.empty();
            }
            final data = widget.data.where((String option) {
              return option.toLowerCase().contains(skillsetTextEditController.text.toLowerCase());
            });

            if (data.isNotEmpty) {
              return data;
            } else {
              return Iterable<String>.generate(1, (int index) {
                return 'Not found';
              });
            }
          },
          onSelected: (String value) {
            textEditingController.text = "";
            if (widget.onSelected != null) {
              widget.onSelected!(value);
            }
          },
        );
      },
    );
  }
}
