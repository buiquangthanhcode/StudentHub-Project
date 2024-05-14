import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/chat_bloc/chat_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/messages/data/get_chat_data.dart';
import 'package:studenthub/ui/home/messages/widgets/chat_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class MessagesCompanyScreen extends StatefulWidget {
  const MessagesCompanyScreen({super.key, this.isHiddenAppbar, this.item});

  final bool? isHiddenAppbar;
  final Project? item;
  @override
  // ignore: library_private_types_in_public_api
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<MessagesCompanyScreen> {
  final searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    // _value = widget.value;
    _searchFocus.addListener(_onFocusChange);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showWelcomeDialog(context);
    // });
    if (widget.item?.id != null) {
      context.read<ChatBloc>().add(
            GetChatListDataOfProjectEvent(
                projectId: widget.item?.id.toString() ?? "0"),
          );
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocus.removeListener(_onFocusChange);

    _searchFocus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  final data = getChatList();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (BuildContext context, ChatState state) {
        if (state.chatListOfProject.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyDataWidget(
                mainTitle: '',
                // subTitle: 'No messages',
                subTitle: noMessageKey.tr(),
                widthImage: MediaQuery.of(context).size.width * 0.5,
              ),
            ],
          );
        }
        return Scaffold(
          appBar: widget.isHiddenAppbar ?? false
              ? null
              : AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  title: Text(
                    'Messages',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.chatListOfProject.length,
                      itemBuilder: (context, index) => ChatItem(
                            chat: Chat.fromMap({
                              ...state.chatListOfProject[index].toMap(),
                              "project": {
                                ...widget.item!.toMap(),
                                'proposals': []
                              },
                            }),
                          )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
