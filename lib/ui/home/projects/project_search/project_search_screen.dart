import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/ui/home/projects/project_search/widgets/filter_dialog.dart';
import 'package:studenthub/ui/home/projects/widgets/general_project_item.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class ProjectSearchScreen extends StatefulWidget {
  const ProjectSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProjectSearchScreenState createState() => _ProjectSearchScreenState();
}

class _ProjectSearchScreenState extends State<ProjectSearchScreen> {
  final searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  final _scrollController = ScrollController();
  final _listController = ScrollController();
  bool scrollToBottom = false;
  bool pinned = false;

  List<String> searchSuggestions = [];
  bool isSearching = true;
  // bool canFocus = true;
  int page = 1;
  bool enableCall = true;
  int preLength = -1;
  dynamic bloc;
  Map<String, dynamic> filterData = {
    'projectScopeFlag': -1,
    'numberOfStudents': '',
    'proposalsLessThan': '',
  };

  @override
  void initState() {
    // _value = widget.value;
    _searchFocus.addListener(_onFocusChange);
    _scrollController.addListener(_scrollListener);

    bloc = context.read<GeneralProjectBloc>();
    setSearchSuggetions('');
    bloc.add(
      GetAllSearchTitleEvent(() {
        setSearchSuggetions('');
      }),
    );

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showWelcomeDialog(context);
    // });

    super.initState();
    _listController.addListener(_scrollToBottomListener);
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _scrollController.removeListener(_scrollListener);
    searchController.dispose();
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
    if (_searchFocus.hasFocus) {
      isSearching = true;
      setSearchSuggetions(searchController.text);
    } else {
      isSearching = false;
    }
    setState(() {});
  }

  void showFilterDialog(TextTheme textTheme) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => FilterDialog(
              applyFilter: (data) {
                filterData = data;
                page = 1;
                bloc.add(GetSearchFilterDataEvent(
                    searchController.text.isEmpty
                        ? null
                        : searchController.text,
                    filterData['projectScopeFlag'],
                    filterData['numberOfStudents'].isEmpty
                        ? null
                        : int.parse(filterData['numberOfStudents']),
                    filterData['proposalsLessThan'].isEmpty
                        ? null
                        : int.parse(filterData['proposalsLessThan']),
                    page,
                    10));
              },
            ));
  }

  void setSearchSuggetions(String value) {
    Set<String> setSuggestion = bloc.state.projectSearchSuggestions;
    searchSuggestions = [];
    if (value.isEmpty) {
      // searchSuggestions.add('View all');
      searchSuggestions.add(viewAllBtnKey.tr());
    } else {
      for (String i in setSuggestion) {
        if (i.toLowerCase().contains(value.toLowerCase())) {
          searchSuggestions.add(i);
        }
      }
    }
    setState(() {});
  }

  void _scrollToBottomListener() {
    if ((_listController.offset == _listController.position.maxScrollExtent) &&
        enableCall) {
      logger.d('scroll to bottom: ${page + 1}');
      enableCall = false;
      preLength = bloc.state.projectSearchList.length;
      bloc.add(GetSearchFilterDataEvent(
          searchController.text.isEmpty ? null : searchController.text,
          filterData['projectScopeFlag'] == -1
              ? null
              : filterData['projectScopeFlag'],
          filterData['numberOfStudents'].isEmpty
              ? null
              : int.parse(filterData['numberOfStudents']),
          filterData['proposalsLessThan'].isEmpty
              ? null
              : int.parse(filterData['proposalsLessThan']),
          ++page,
          10));
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    // Future.delayed(Duration.zero, () {
    //   showFilterDialog(textTheme);
    // });
    // if (isSearching) {
    //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    // }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          // 'Project search',
          projectSearchTitleKey.tr(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {
                        // canFocus = true;
                        isSearching = true;
                        setSearchSuggetions(searchController.text);
                      },
                      // onTapOutside: (event) {
                      //   FocusScope.of(context).unfocus();
                      // },
                      focusNode: _searchFocus,
                      onChanged: (value) {
                        // if (value.isEmpty || value.length == 1) {
                        //   setState(() {});
                        // }
                        isSearching = true;
                        setSearchSuggetions(value);
                      },
                      cursorHeight: 18,
                      // autofocus: true,
                      controller: searchController,
                      cursorColor: Colors.black,
                      style: textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // hintText: 'Search for projects...',
                        hintText: searchForProjectsKey.tr(),
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
                                    onTap: () {
                                      searchController.clear();
                                      setSearchSuggetions('');
                                      isSearching = true;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 191, 191, 191),
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
                            horizontal: 15, vertical: 12),
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
                  if (!isSearching)
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showFilterDialog(textTheme);
                          },
                          child: Container(
                            height: 49,
                            width: 49,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 245, 245, 245),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'lib/assets/svgs/filter.svg',
                              colorFilter: ColorFilter.mode(
                                colorTheme.black!,
                                BlendMode.srcIn,
                              ),
                              height: 24,
                            ),
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
            if (isSearching)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Suggestions',
                        suggestionsKey.tr(),
                        style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorTheme.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchSuggestions.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              // FocusScope.of(context).unfocus();
                              // WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                              isSearching = false;
                              page = 1;
                              filterData = {
                                'projectScopeFlag': -1,
                                'numberOfStudents': '',
                                'proposalsLessThan': '',
                              };
                              if (index == 0 && searchController.text.isEmpty) {
                                bloc.add(GetSearchFilterDataEvent(
                                    null, null, null, null, page, 10));
                              } else {
                                searchController.text =
                                    searchSuggestions[index];
                                bloc.add(GetSearchFilterDataEvent(
                                    searchController.text,
                                    null,
                                    null,
                                    null,
                                    page,
                                    10));
                              }
                              setState(() {});
                            },
                            child: index != 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 15),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: colorTheme.hintColor!))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          searchSuggestions[index],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )),
                                        const Spacer(),
                                        FaIcon(
                                          FontAwesomeIcons
                                              .arrowUpRightFromSquare,
                                          size: 20,
                                          color: colorTheme.grey,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: searchController.text.isEmpty
                                            ? primaryColor
                                            : Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: colorTheme.hintColor!))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          style: TextStyle(
                                              color:
                                                  searchController.text.isEmpty
                                                      ? Colors.white
                                                      : Colors.black),
                                          searchSuggestions[index],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )),
                                        const Spacer(),
                                        FaIcon(
                                          FontAwesomeIcons
                                              .arrowUpRightFromSquare,
                                          size: 20,
                                          color: searchController.text.isEmpty
                                              ? Colors.white
                                              : colorTheme.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!isSearching)
              BlocBuilder<GeneralProjectBloc, GeneralProjectState>(
                builder: (context, state) {
                  enableCall = true;
                  return Expanded(
                    child: state.projectSearchList.isNotEmpty
                        ? ListView.builder(
                            controller: _listController,
                            shrinkWrap: true,
                            itemCount: state.projectSearchList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.projectSearchList.length) {
                                return GeneralProjectItem(
                                  project: state.projectSearchList[index],
                                  paddingRight: 12,
                                );
                              } else {
                                logger.d("PRE: $preLength");
                                logger.d(
                                    "SEARCH: ${state.projectSearchList.length}");
                                return state.projectSearchList.isNotEmpty
                                    ? (preLength !=
                                                state
                                                    .projectSearchList.length &&
                                            state.projectSearchList.length >=
                                                10)
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 36),
                                              child: CircularProgressIndicator(
                                                color: primaryColor,
                                                strokeWidth: 5,
                                              ),
                                            ),
                                          )
                                        : const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 24),
                                              child:
                                                  Text('No more data to load'),
                                            ),
                                          )
                                    : null;
                              }
                            })
                        : Center(
                            child: EmptyDataWidget(
                              mainTitle: '',
                              // subTitle: "No projects found.",
                              subTitle: noProjectFoundKey.tr(),
                              widthImage:
                                  MediaQuery.of(context).size.width * 0.5,
                            ),
                          ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
