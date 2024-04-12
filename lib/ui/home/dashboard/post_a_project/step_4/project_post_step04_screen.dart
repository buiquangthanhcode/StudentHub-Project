import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/blocs/company_bloc/company_state.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/blocs/project_bloc/project_state.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/widgets/bulletWidget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ProjectPostStep04Screen extends StatefulWidget {
  const ProjectPostStep04Screen({super.key});

  @override
  State<ProjectPostStep04Screen> createState() =>
      _ProjectPostStep04ScreenState();
}

class _ProjectPostStep04ScreenState extends State<ProjectPostStep04Screen> {
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
              "Review your post",
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
                  percent: 1.0,
                  progressColor: const Color(0xff3961FB),
                  backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '4 of 4',
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please review the content before posting",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black.withOpacity(0.6),
                          ),
                    ),
                    const SizedBox(height: 36),
                    // Text(
                    //   'Face advertisement specialist need for product launch',
                    //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black.withOpacity(0.8),
                    //       ),
                    // ),
                    Text(
                      state.project.title ?? 'None title',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.8),
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 2, // Set the thickness of the divider
                      height: 20, // Set the height of the divider
                      // indent:
                      //     10, // Set the amount of empty space before the divider
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Students are looking for',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                        ),
                        // BulletList(const [
                        //   'Clear expectation about your project or deliverables',
                        //   'The skill required for your project',
                        //   'Detail about your project',
                        // ]),
                        BulletList([
                          if (state.project.description != null)
                            state.project.description!
                          else
                            'None description'
                        ]),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 2, // Set the thickness of the divider
                      height: 20, // Set the height of the divider
                      // indent:
                      //     10, // Set the amount of empty space before the divider
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.access_alarm, size: 42),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project scope',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidCircle,
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    state.project.projectScopeFlag == 0
                                        ? '1-3 months'
                                        : '3-6 months',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.people, size: 42),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student required',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidCircle,
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    state.project.numberOfStudents.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // const SizedBox(height: 24),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // context.push('/');
                    context.read<ProjectBloc>().add(PostNewProjectEvent(
                        newProject: Project.fromMap({
                          ...state.project.toMap(),
                          "companyId": "39",
                          "typeFlag": 0
                        }),
                        onSuccess: () {
                          SnackBarService.showSnackBar(
                              content: 'Successfully!',
                              status: StatusSnackBar.success);
                          context.pushNamed('home');
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Adjust padding as needed
                      minimumSize: const Size(
                          double.infinity, 48) // Set minimum button size
                      ),
                  child: Text(
                    'Post a job',
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
