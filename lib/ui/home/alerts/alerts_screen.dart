import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/notification_bloc/notification_bloc.dart';
import 'package:studenthub/blocs/notification_bloc/notification_event.dart';
import 'package:studenthub/blocs/notification_bloc/notification_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/utils/helper.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<AlertsScreen> {
  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;
  late AuthenState _authenState;

  final data = [
    {'seen': false, 'type': 'message', 'title': 'Alex Jor', 'content': 'How are you?', 'time': '13:30'},
    {
      'seen': true,
      'type': 'submitted',
      'title': 'You have submited to join project "Javis - AI Copilot"',
      'content': '',
      'time': '6/6/2024'
    },
    {
      'seen': true,
      'type': 'interview',
      'title': 'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday',
      'content': '',
      'time': '6/6/2024'
    },
    {
      'seen': false,
      'type': 'offer',
      'title': 'You have offer to join project "Javis - AI Copilot"',
      'content': '',
      'time': '2/6/2024'
    },
    {
      'seen': false,
      'type': 'submitted',
      'title': 'You have submited to join project "Javis - AI Copilot"',
      'content': '',
      'time': '6/6/2024'
    },
    {
      'seen': false,
      'type': 'interview',
      'title': 'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday',
      'content': '',
      'time': '6/6/2024'
    },
    {
      'seen': true,
      'type': 'interview',
      'title': 'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday',
      'content': '',
      'time': '6/6/2024'
    },
    {
      'seen': true,
      'type': 'offer',
      'title': 'You have offer to join project "Javis - AI Copilot"',
      'content': '',
      'time': '2/6/2024'
    },
    {
      'seen': false,
      'type': 'offer',
      'title': 'You have offer to join project "Javis - AI Copilot"',
      'content': '',
      'time': '2/6/2024'
    }
  ];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _authenState = context.read<AuthBloc>().state;
    context.read<NotificationBloc>().add(
          GetNotificationListEvents(
            onSuccess: () {},
            userId: (_authenState.userModel.id ?? 0).toString(),
          ),
        );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      if (scrollToBottom) {
        setState(() {
          scrollToBottom = false;
          pinned = true;
        });
      }
    } else if (direction == ScrollDirection.reverse) {
      if (!scrollToBottom) {
        setState(() {
          scrollToBottom = true;
          pinned = false;
        });
      }
    }
  }

  void showOptionsDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidEnvelopeOpen,
                    size: 21,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Mark all as read')
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;

    // Future.delayed(Duration.zero, () {
    //   showOptionsDialog();
    // });

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 60,
            collapsedHeight: 60,
            elevation: 0,
            pinned: pinned,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alerts',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      showOptionsDialog();
                    },
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: colorTheme.brightness == Brightness.dark
                            ? primaryColor
                            : const Color.fromARGB(255, 245, 245, 245),
                      ),
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.gear,
                        color: colorTheme.black,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.notificationList.length,
                  (BuildContext context, int index) {
                    return NotificationItem(
                      item: state.notificationList[index],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screenSize = MediaQuery.of(context).size;
    Widget button = const SizedBox();
    Widget content = const SizedBox();
    SvgPicture icon;
    switch (item.typeNotifyFlag) {
      case '1': // interview
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: ColorFilter.mode((item.notifyFlag == "0") ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        button = SizedBox(
          width: screenSize.width * 0.4,
          height: 36,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Join'),
          ),
        );
        break;
      case '0': // offer
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: ColorFilter.mode((item.notifyFlag == "0") ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        content = Text(
          item.content ?? '',
          style: TextStyle(color: (item.notifyFlag == "0") ? colorTheme.grey! : Colors.black, fontSize: 12),
        );
        button = SizedBox(
          width: screenSize.width * 0.4,
          height: 36,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(
                'project_general_detail',
                queryParameters: {
                  'id': (item.proposal?.projectId ?? 0).toString(),
                  'isFavorite': 'null',
                  'proposalId': item.proposal?.id.toString(),
                },
              );
            },
            child: const Text('View offer'),
          ),
        );
        break;
      case '2': // submit
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: ColorFilter.mode((item.notifyFlag == "0") ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        break;
      case '3': // chat
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/messages.svg',
          colorFilter: ColorFilter.mode((item.notifyFlag == "0") ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        content = Text(
          item.content ?? '',
          style: TextStyle(color: (item.notifyFlag == "0") ? colorTheme.grey! : Colors.black, fontSize: 12),
        );
        break;
      default:
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: const ColorFilter.mode(Color(0xffA0A0A0), BlendMode.srcIn),
          height: 23,
        );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 235, 239, 255),
        border: Border(bottom: BorderSide(width: 1, color: colorTheme.hintColor!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color.fromARGB(255, 245, 245, 245), shape: BoxShape.circle),
            child: icon,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? '',
                  style: textTheme.bodySmall,
                ),
                content,
                const SizedBox(
                  height: 10,
                ),
                Text(
                  checkDateTime(item.createdAt ?? ''),
                  style: TextStyle(
                    color: colorTheme.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                button,
              ],
            ),
          ),
          Container(
            width: 20,
            alignment: Alignment.center,
            child: (item.notifyFlag == "0")
                ? const SizedBox()
                : const FaIcon(
                    FontAwesomeIcons.solidCircle,
                    size: 8,
                    color: primaryColor,
                  ),
          )
        ],
      ),
    );
  }
}
