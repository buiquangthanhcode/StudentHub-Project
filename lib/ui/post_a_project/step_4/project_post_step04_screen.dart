import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/constants/colors.dart';

class ProjectPostStep04 extends StatelessWidget {
  const ProjectPostStep04({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Write project details",
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
                percent: 1,
                progressColor: const Color(0xff3961FB),
                backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text('4 of 4',
                    style: Theme.of(context).textTheme.bodySmall)),
          )
        ],
      ),
      body: ElevatedButton(
        onPressed: () {
          context.push('/dashboard');
        },
        child: const Text('Continue'),
      ),
    );
  }
}
