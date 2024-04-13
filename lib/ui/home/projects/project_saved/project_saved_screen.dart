import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_bloc.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_event.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_state.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/ui/home/projects/project_saved/widgets/project_item_saved.dart';

class ProjectSavedScreen extends StatefulWidget {
  const ProjectSavedScreen({Key? key}) : super(key: key);

  @override
  _ProjectSavedState createState() => _ProjectSavedState();
}

class _ProjectSavedState extends State<ProjectSavedScreen> {
  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();

    context.read<AllProjectBloc>().add(
          GetFavoriteProject(
              studentId: context
                  .read<AuthBloc>()
                  .state
                  .userModel
                  .student!
                  .id
                  .toString()),
        );
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
    return BlocBuilder<AllProjectBloc, AllProjectState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                titleSpacing: 0,
                expandedHeight: 60,
                collapsedHeight: 60,
                elevation: 0,
                pinned: pinned,
                centerTitle: false,
                title: Text(
                  'Saved Project',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.projectFavorite.length,
                  (BuildContext context, int index) {
                    return ProjectItemSaved(
                      project: state.projectFavorite[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
