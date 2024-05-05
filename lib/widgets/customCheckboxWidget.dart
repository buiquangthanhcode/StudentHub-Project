import 'package:flutter/material.dart';
import 'package:studenthub/constants/colors.dart';

// You can also use stateful builder
// instead of stateful widget
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // Fixed height and width is given so
      // that it won't get change in responsiveness
      width: 20,
      height: 20,
      alignment: Alignment.center, // Alignment as center
      decoration: const BoxDecoration(
        // TODO: you can change here gradient color
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: InkWell(
        onTap: () {
          // To change the state of isChecked variable
          setState(() {
            isChecked = !isChecked;
          });
        },
        // TODO: Here you can see border of checkbox if
        // ischecked is true , else gradient color of checkbox
        child: isChecked
            ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
            : Padding(
                padding: const EdgeInsets.all(1.5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
      ),
    );
  }
}
