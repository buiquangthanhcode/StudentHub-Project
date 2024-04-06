import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/blocs/company_bloc/company_state.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/widgets/bulletWidget.dart';

class ProjectPostStep03Screen extends StatefulWidget {
  const ProjectPostStep03Screen({super.key});

  @override
  State<ProjectPostStep03Screen> createState() =>
      _ProjectPostStep03ScreenState();
}

class _ProjectPostStep03ScreenState extends State<ProjectPostStep03Screen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        log("state in step 3: ${state}");
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              "Write project description",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CircularPercentIndicator(
                  animation: true,
                  // animationDuration: 10000,
                  radius: 60,
                  lineWidth: 6,
                  percent: 0.75,
                  progressColor: const Color(0xff3961FB),
                  backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '3 of 4',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13,
                        ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Provide a detailed description for your project",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  ),
                  const SizedBox(height: 36),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Students are looking for',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                      BulletList(const [
                        'Clear expectation about your project or deliverables',
                        'The skill required for your project',
                        'Detail about your project',
                      ])
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Describe your project',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                        // textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _textEditingController,
                        cursorHeight: 20,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium, // Adjust the font size as needed
                        maxLines: null, // Allows multiple lines
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction
                            .newline, // Use 'newline' action for 'Done' button
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: const Color.fromARGB(255, 149, 148, 148),
                              ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 4.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  // const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // context.push('/project_post/step_04');
                      final currentProject = {
                        ...state.project.toMap(),
                        'description': _textEditingController.text
                      };
                      Project newProject = Project.fromMap(currentProject);
                      context
                          .read<CompanyBloc>()
                          .add(UpdateNewProjectEvent(newProject));
                      context.push('/home/project_post/step_04');
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Adjust padding as needed
                        minimumSize: const Size(
                            double.infinity, 48) // Set minimum button size
                        ),
                    child: Text(
                      'Continue',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
