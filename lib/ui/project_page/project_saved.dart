import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/ui/project_page/project_page_.dart';

class ProjectSaved extends StatefulWidget {
  const ProjectSaved({Key? key}) : super(key: key);

  @override
  _ProjectSavedState createState() => _ProjectSavedState();
}

class _ProjectSavedState extends State<ProjectSaved> {
  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

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
            pinned: pinned,
            title: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                Text(
                  'Saved Project',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (BuildContext context, int index) {
                return SavedProjectItem(
                    colorTheme: colorTheme, textTheme: textTheme);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SavedProjectItem extends StatelessWidget {
  const SavedProjectItem({
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
                FontAwesomeIcons.solidHeart,
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
