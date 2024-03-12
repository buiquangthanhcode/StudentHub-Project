import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

class ProjectPage_ extends StatefulWidget {
  const ProjectPage_({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage_> {
  final searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();

  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

  @override
  void initState() {
    // _value = widget.value;
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
    // _scrollController.
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
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: SafeArea(
          bottom: false,
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            duration: const Duration(milliseconds: 200),
            height: _searchFocus.hasFocus ? 0 : 50,
            child: Text(
              'Projects',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            collapsedHeight: 70,
            elevation: 0,
            pinned: pinned || _searchFocus.hasFocus,
            title: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(microseconds: 400),
                  // height: scrollToBottom ? 0 : 63,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: _searchFocus,
                          onChanged: (value) {},
                          cursorHeight: 18,
                          controller: searchController,
                          cursorColor: Colors.black,
                          style: textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Search for projects...',
                            hintStyle: textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.hintColor),
                            prefixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: colorTheme.black,
                                ),
                              ],
                            ),
                            suffixIcon: searchController.text.isNotEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 191, 191, 191),
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
                            suffixIconConstraints:
                                const BoxConstraints(minWidth: 50),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            isDense: true,
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 245, 245),
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
                      const SizedBox(
                        width: 10,
                      ),
                      // ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //         minimumSize: const Size(48, 48),
                      //         padding: EdgeInsets.zero,
                      //         shape: const CircleBorder(),
                      //         backgroundColor: primaryColor),
                      //     child: const FaIcon(
                      //       FontAwesomeIcons.solidHeart,
                      //       color: Colors.white,
                      //     )),
                      InkWell(
                        onTap: () {
                          // showWelcomeDialog(context);
                        },
                        child: Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 245, 245, 245),
                          ),
                          alignment: Alignment.center,
                          child: FaIcon(
                            FontAwesomeIcons.heart,
                            color: colorTheme.black,
                          ),
                        ),
                      )
                    ],
                  ),
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
      padding: const EdgeInsets.fromLTRB(0, 16, 15, 16),
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
