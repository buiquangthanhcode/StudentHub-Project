import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/ui/home/messages/widgets/chat_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, this.isHiddenAppbar});

  final bool? isHiddenAppbar;
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<MessagesScreen> {
  final searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  List<Chat> chatListSearch = [];

  @override
  void initState() {
    // _value = widget.value;
    _searchFocus.addListener(_onFocusChange);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showWelcomeDialog(context);
    // });
    context.read<ChatBloc>().add(
          GetAllDataEvent(),
        );

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

  // final data = getChatList();

  void searchChat(List<Chat> data) {
    String value = searchController.text.trim();
    String myId = context.read<AuthBloc>().state.userModel.id.toString();
    if (value.isNotEmpty) {
      chatListSearch = data.where((chat) {
        String chattingUserId =
            chat.sender['id'].toString() != myId ? chat.sender['id'].toString() : chat.receiver['id'].toString();

        String username = chat.sender['id'].toString() == chattingUserId
            ? chat.sender['fullname'] ?? ''
            : chat.receiver['fullname'] ?? '';
        return chat.project.title!.toLowerCase().contains(value.toLowerCase()) ||
            username.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return BlocBuilder<ChatBloc, ChatState>(builder: (BuildContext context, ChatState state) {
      return Scaffold(
        appBar: widget.isHiddenAppbar ?? false
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: Text(
                  // 'Messages',
                  messagesNavKey.tr(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      context.pushNamed('active_interview');
                    },
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: theme.colorScheme.brightness == Brightness.dark
                            ? primaryColor
                            : const Color.fromARGB(255, 245, 245, 245),
                      ),
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.solidCalendarCheck,
                        color: colorTheme.black,
                        size: 21,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: _searchFocus,
                        onChanged: (value) {
                          searchChat(state.chatList);
                        },
                        // onSubmitted: (value) {
                        //   context.read<ChatBloc>().add(
                        //         SearchChatEvent(search: value),
                        //       );
                        // },
                        cursorHeight: 18,
                        controller: searchController,
                        cursorColor: Colors.black,
                        style: textTheme.bodyMedium!.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: searchForMsgKey.tr(),
                          hintStyle: textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.hintColor),
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: theme.colorScheme.brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.hintColor
                                    : colorTheme.black,
                              ),
                            ],
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        searchController.clear();
                                        setState(() {});
                                        context.read<ChatBloc>().add(
                                              GetAllDataEvent(),
                                            );
                                      },
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorTheme.brightness == Brightness.dark
                                              ? primaryColor
                                              : const Color.fromARGB(255, 191, 191, 191),
                                        ),
                                        child: const FaIcon(
                                          FontAwesomeIcons.xmark,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(width: 1),
                          suffixIconConstraints: const BoxConstraints(minWidth: 50),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          isDense: true,
                          filled: true,
                          fillColor: colorTheme.brightness == Brightness.dark
                              ? Colors.white
                              : const Color.fromARGB(255, 245, 245, 245),
                          errorStyle: const TextStyle(height: 0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // disabledBorder: const OutlineInputBorder(
                          //   borderSide: BorderSide(width: 0),
                          //   borderRadius: BorderRadius.all(Radius.circular(8)),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: searchController.text.isEmpty
                      ? state.chatList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.chatList.length,
                              itemBuilder: (context, index) => ChatItem(
                                    chat: state.chatList[index],
                                  ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: EmptyDataWidget(
                                    mainTitle: '',
                                    // subTitle: "You haven't received any messages yet.",
                                    // subTitle: noProjectFoundKey.tr(),
                                    subTitle: noMessagesAlertKey.tr(),
                                    widthImage: MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ),
                              ],
                            )
                      : chatListSearch.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: chatListSearch.length,
                              itemBuilder: (context, index) => ChatItem(
                                    chat: chatListSearch[index],
                                  ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: EmptyDataWidget(
                                    mainTitle: '',
                                    // subTitle: "You haven't received any messages yet.",
                                    // subTitle: noProjectFoundKey.tr(),
                                    subTitle: "The chat cannot be found.",
                                    widthImage: MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ),
                              ],
                            )),
            ],
          ),
        ),
      );
    });
  }
}
