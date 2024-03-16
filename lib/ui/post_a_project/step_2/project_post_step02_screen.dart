import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/constants/colors.dart';

class ProjectPostStep02 extends StatelessWidget {
  const ProjectPostStep02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Estimate your job scope",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 18,
                )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircularPercentIndicator(
                animation: true,
                // animationDuration: 10000,
                radius: 70,
                lineWidth: 8,
                percent: 0.5,
                progressColor: const Color(0xff3961FB),
                backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text('2 of 4',
                    style: Theme.of(context).textTheme.bodySmall)),
          )
        ],
      ),
      body: ElevatedButton(
        onPressed: () {
          context.push('/project_post/step_03');
        },
        child: const Text('Continue'),
      ),
    );
  }
}
