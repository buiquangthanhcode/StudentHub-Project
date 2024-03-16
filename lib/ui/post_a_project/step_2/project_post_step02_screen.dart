import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/constants/colors.dart';

enum TimeOption { option1, option2 }

class ProjectPostStep02 extends StatefulWidget {
  const ProjectPostStep02({super.key});

  @override
  State<ProjectPostStep02> createState() => _ProjectPostStep02State();
}

class _ProjectPostStep02State extends State<ProjectPostStep02> {
  late TimeOption _timeOption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeOption = TimeOption.option1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Estimate your job scope",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18,
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
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Consider the size of your project and timeline",
              ),
              const SizedBox(height: 24),
              Text(
                'How long will your project take?',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Column(
                children: [
                  RadioListTile(
                    activeColor: primaryColor,
                    visualDensity:
                        const VisualDensity(vertical: -2.0, horizontal: -4.0),
                    title: Text('1 to 3 months',
                        style: Theme.of(context).textTheme.bodyMedium),
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
                      '3 to 6 months',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    value: TimeOption.option2,
                    groupValue: _timeOption,
                    onChanged: (value) {
                      setState(() {
                        _timeOption = value as TimeOption;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'How many students do you want for this project?',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium, // Adjust the font size as needed
                decoration: InputDecoration(
                  hintText: 'The number of students',
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
                onChanged: (value) {
                  // print('Input value: $value');
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.push('/project_post/step_03');
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
            ],
          )),
      //  ElevatedButton(
      //     onPressed: () {
      //       context.push('/project_post/step_03');
      //     },
      //     child: const Text('Continue'),
      //   ),
    );
  }
}
