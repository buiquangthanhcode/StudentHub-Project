import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

  final data = [
    {
      'seen': false,
      'type': 'message',
      'title': 'Alex Jor',
      'content': 'How are you?',
      'time': '13:30'
    },
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
      'title':
          'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday',
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
      'title':
          'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday',
      'content': '',
      'time': '6/6/2024'
    },
    {
      'seen': true,
      'type': 'interview',
      'title':
          'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday',
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showWelcomeDialog(context);
    // });
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
                        color: const Color.fromARGB(255, 245, 245, 245),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: data.length,
              (BuildContext context, int index) {
                return NotificationItem(
                  data: data[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screen_size = MediaQuery.of(context).size;
    Widget button = const SizedBox();
    Widget content = const SizedBox();
    SvgPicture icon;
    switch (data['type']) {
      case 'interview':
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: ColorFilter.mode(
              data['seen'] ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        button = SizedBox(
          width: screen_size.width * 0.4,
          height: 36,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Join'),
          ),
        );
        break;
      case 'offer':
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: ColorFilter.mode(
              data['seen'] ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        button = SizedBox(
          width: screen_size.width * 0.4,
          height: 36,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('View offer'),
          ),
        );
        break;
      case 'submitted':
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter: ColorFilter.mode(
              data['seen'] ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        break;
      case 'message':
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/messages.svg',
          colorFilter: ColorFilter.mode(
              data['seen'] ? colorTheme.grey! : Colors.black, BlendMode.srcIn),
          height: 18,
        );
        content = Text(
          data['content'],
          style: TextStyle(
              color: data['seen'] ? colorTheme.grey! : Colors.black,
              fontSize: 12),
        );
        break;
      default:
        icon = SvgPicture.asset(
          'lib/assets/nav_icons/solid/ballot-check.svg',
          colorFilter:
              const ColorFilter.mode(Color(0xffA0A0A0), BlendMode.srcIn),
          height: 23,
        );
        print('Bottom navigation error!');
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 235, 239, 255),
        border:
            Border(bottom: BorderSide(width: 1, color: colorTheme.hintColor!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245),
                shape: BoxShape.circle),
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
                  data['title'],
                  style: textTheme.bodySmall,
                ),
                content,
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data['time'],
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
            child: data['seen']
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
