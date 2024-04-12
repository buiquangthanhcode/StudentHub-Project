import 'package:flutter/material.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class ProjectWorkingTabForCompany extends StatelessWidget {
  const ProjectWorkingTabForCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyDataWidget(
            mainTitle: '',
            subTitle: 'No project working yet.',
            widthImage: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
      ),
    );
  }
}
