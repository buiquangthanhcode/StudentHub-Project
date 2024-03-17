import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/ui/home/projects/widgets/project_item.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

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
    var screenSize = MediaQuery.of(context).size;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'lib/assets/images/welcome_image_dialog.png',
                      width: screenSize.width * 0.5,
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
    // TextTheme textTheme = Theme.of(context).textTheme;
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
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
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
                        onTap: () {
                          context.goNamed('project_search');
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
                          context.goNamed('project_saved');
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (BuildContext context, int index) {
                return const ProjectItem(
                  paddingRight: 8,
                  icon: FontAwesomeIcons.heart,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
