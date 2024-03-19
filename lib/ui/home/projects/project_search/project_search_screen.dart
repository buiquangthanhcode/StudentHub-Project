import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/ui/home/projects/project_search/widgets/filter_dialog.dart';
import 'package:studenthub/ui/home/projects/widgets/project_item.dart';

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

  void showFilterDialog(TextTheme textTheme) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => const FilterDialog());
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    // Future.delayed(Duration.zero, () {
    //   showFilterDialog(textTheme);
    // });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Project search',
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
                      focusNode: _searchFocus,
                      onChanged: (value) {
                        if (value.isEmpty || value.length == 1) {
                          setState(() {});
                        }
                      },
                      cursorHeight: 18,
                      autofocus: true,
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
                                    onTap: () {
                                      searchController.clear();
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
                  if (!_searchFocus.hasFocus &&
                      searchController.text.isNotEmpty)
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
            if (_searchFocus.hasFocus || searchController.text.isEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recents',
                        style: textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 16,
                          itemBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.clock,
                                  size: 21,
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Text('ReactJs')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!_searchFocus.hasFocus && searchController.text.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) => const ProjectItem(
                          paddingRight: 12,
                          icon: FontAwesomeIcons.heart,
                        )),
              ),
          ],
        ),
      ),
    );
  }
}
