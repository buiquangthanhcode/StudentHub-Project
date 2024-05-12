import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/blocs/project_bloc/project_state.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';

enum TimeOption { option1, option2, option3, option4 }

class ProjectPostStep02Screen extends StatefulWidget {
  const ProjectPostStep02Screen({super.key});

  @override
  State<ProjectPostStep02Screen> createState() => _ProjectPostStep02State();
}

class _ProjectPostStep02State extends State<ProjectPostStep02Screen> {
  final TextEditingController _textEditingController = TextEditingController();
  late TimeOption _timeOption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeOption = TimeOption.option1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              estimateJobKey.tr(),
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
                  percent: 0.5,
                  progressColor: const Color(0xff3961FB),
                  backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '2 of 4',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13,
                        ),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  estimateJobDescriptionKey.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                ),
                const SizedBox(height: 36),
                Text(
                  estimateJobQ1Key.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),
                      ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 12),
                    RadioListTile(
                      activeColor: primaryColor,
                      visualDensity:
                          const VisualDensity(vertical: -4.0, horizontal: -4.0),
                      title: Text(
                        lessThan1MonthKey.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                      value: TimeOption.option1,
                      groupValue: _timeOption,
                      onChanged: (value) {
                        setState(() {
                          _timeOption = value as TimeOption;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: primaryColor,
                      visualDensity:
                          const VisualDensity(vertical: -4.0, horizontal: -4.0),
                      title: Text(
                        oneToThreeMonthsKey.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                      value: TimeOption.option2,
                      groupValue: _timeOption,
                      onChanged: (value) {
                        setState(() {
                          _timeOption = value as TimeOption;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: primaryColor,
                      visualDensity:
                          const VisualDensity(vertical: -4.0, horizontal: -4.0),
                      title: Text(
                        threeToSixMonthsKey.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                      value: TimeOption.option3,
                      groupValue: _timeOption,
                      onChanged: (value) {
                        setState(() {
                          _timeOption = value as TimeOption;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: primaryColor,
                      visualDensity:
                          const VisualDensity(vertical: -4.0, horizontal: -4.0),
                      title: Text(
                        moreThan6MonthsKey.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                      value: TimeOption.option4,
                      groupValue: _timeOption,
                      onChanged: (value) {
                        setState(() {
                          _timeOption = value as TimeOption;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  estimateJobQ2Key.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),
                      ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _textEditingController,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Adjust the font size as needed
                  decoration: InputDecoration(
                    hintText: estimateJobQ2PlaceHolderKey.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color.fromARGB(255, 149, 148, 148),
                        ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 4.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12 // Adjust the vertical padding as needed
                        ),
                  ),
                  onChanged: (value) {},
                ),
                // const SizedBox(height: 24),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    final currentProject = Project(
                      title: state.projectCreation.title,
                      projectScopeFlag: _timeOption == TimeOption.option1
                          ? 0
                          : _timeOption == TimeOption.option2
                              ? 1
                              : _timeOption == TimeOption.option3
                                  ? 2
                                  : 3,
                      numberOfStudents: int.parse(_textEditingController.text),
                    );
                    context
                        .read<ProjectBloc>()
                        .add(UpdateNewProjectEvent(currentProject));
                    context.push('/home/project_post/step_03');
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Adjust padding as needed
                      minimumSize: const Size(
                          double.infinity, 48) // Set minimum button size
                      ),
                  child: Text(
                    continueBtnKey.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        );
      },
    );
  }
}
