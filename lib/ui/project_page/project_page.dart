import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();

  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

  @override
  void initState() {
    _searchFocus.addListener(_onFocusChange);
    _scrollController.addListener(_scrollListener);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showWelcomeDialog(context);
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _scrollController.removeListener(_scrollListener);

    _searchFocus.dispose();
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

  void _onFocusChange() {
    setState(() {});
  }

  void showWelcomeDialog(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screen_size = MediaQuery.of(context).size;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: screen_size.width * 0.8,
                height: screen_size.height * 0.5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'lib/assets/images/welcome_image_dialog.png',
                      width: screen_size.width * 0.5,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Welcome to Student Hub',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Start searching and implementing real-world projects right now!',
                      textAlign: TextAlign.center,
                      style:
                          textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Get Started!',
                        style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            collapsedHeight: 60,
            elevation: 0,
            pinned: pinned || _searchFocus.hasFocus,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Projects',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 39,
                        width: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 245, 245, 245),
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: colorTheme.black,
                          size: 21,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        // showWelcomeDialog(context);
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
                          FontAwesomeIcons.solidHeart,
                          color: colorTheme.black,
                          size: 21,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (BuildContext context, int index) {
                return ProjectItem(
                    colorTheme: colorTheme, textTheme: textTheme);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    super.key,
    required this.colorTheme,
    required this.textTheme,
  });

  final ColorScheme colorTheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 15),
      padding: const EdgeInsets.fromLTRB(0, 16, 10, 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: colorTheme.hintColor!))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Created 3 days ago',
                      style:
                          textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                    ),
                    Text(
                      'Senior frontend developer (Fintech)',
                      style: textTheme.bodySmall!.copyWith(color: primaryColor),
                    ),
                    Text(
                      'Time: 1-3 months, 6 students needed',
                      style: textTheme.bodySmall!.copyWith(
                        color: colorTheme.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.heart,
                color: primaryColor,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Students are looking for',
            style: textTheme.bodySmall!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(6),
                      child: FaIcon(
                        FontAwesomeIcons.solidCircle,
                        size: 6,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Clear expectation about your project or deliverables',
                        style: textTheme.bodySmall!,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text('Proposal: Less than 5',
              style: textTheme.bodySmall!.copyWith(color: colorTheme.grey)),
        ],
      ),
    );
  }
}
