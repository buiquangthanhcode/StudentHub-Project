import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/ui/home/messages/active_interview/widgets/interview_widget.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class ActiveInterviewScreen extends StatefulWidget {
  const ActiveInterviewScreen({super.key});

  @override
  State<ActiveInterviewScreen> createState() => _ActiveInterviewScreenState();
}

class _ActiveInterviewScreenState extends State<ActiveInterviewScreen> {
  bool? isSaved;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(
          GetActiveInterviewEvent(
              userId: context.read<AuthBloc>().state.userModel.id.toString()),
        );
  }

  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;

    return BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 64),
          child: AppBar(
            titleSpacing: 0,
            title: Text(
              "Active Interview",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            centerTitle: false,
          ),
        ),
        body: state.activeInterview.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: state.activeInterview.length,
                itemBuilder: (context, index) => InterviewWidget(
                  colorTheme: colorTheme,
                  interview: state.activeInterview[index],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: EmptyDataWidget(
                      mainTitle: '',
                      subTitle: "You haven't any interviews yet.",
                      // subTitle: noProjectFoundKey.tr(),
                      widthImage: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
