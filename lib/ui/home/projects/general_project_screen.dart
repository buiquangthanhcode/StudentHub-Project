import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/ui/home/projects/widgets/general_project_item.dart';

class GeneralProjectScreen extends StatefulWidget {
  const GeneralProjectScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GeneralProjectScreenState createState() => _GeneralProjectScreenState();
}

class _GeneralProjectScreenState extends State<GeneralProjectScreen> {
  final searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

  @override
  void initState() {
    _searchFocus.addListener(_onFocusChange);
    _scrollController.addListener(_scrollListener);

    super.initState();

    context.read<GeneralProjectBloc>().add(
          GetAllDataEvent(),
        );
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

  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    AuthenState authSate = context.read<AuthBloc>().state;

    return BlocBuilder<GeneralProjectBloc, GeneralProjectState>(
      builder: (BuildContext context, GeneralProjectState state) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
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
                              context.pushNamed('project_search');
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
                          Visibility(
                            visible: authSate.currentRole == UserRole.student,
                            child: InkWell(
                              onTap: () {
                                context.pushNamed('project_saved');
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.projectList.length,
                  (BuildContext context, int index) {
                    return GeneralProjectItem(
                      project: state.projectList[index],
                      paddingRight: 8,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
