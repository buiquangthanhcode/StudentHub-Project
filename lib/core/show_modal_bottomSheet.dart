// ignore: file_names
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

Future<void> showModalBottomSheetCustom(BuildContext context,
    {Widget? widgetBuilder, Widget? headerBuilder, double? height}) async {
  await showModalBottomSheet(
      isScrollControlled: true,
      // isDismissible: false,
      // useSafeArea: true,
      // elevation: 0.2,
      // enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggleBottomSheetCustom(
            widgetBuilder: widgetBuilder,
            headerBuilder: headerBuilder,
            height: height,
          ));
}

class DraggleBottomSheetCustom extends StatefulWidget {
  const DraggleBottomSheetCustom({
    super.key,
    this.widgetBuilder,
    this.headerBuilder,
    this.height,
  });

  final Widget? widgetBuilder;
  final Widget? headerBuilder;
  final double? height;

  @override
  State<DraggleBottomSheetCustom> createState() =>
      _DraggleBottomSheetCustomState();
}

class _DraggleBottomSheetCustomState extends State<DraggleBottomSheetCustom> {
  late double _sheetPosition;
  final double _dragSensitivity = 600;

  @override
  void initState() {
    super.initState();
    _sheetPosition = widget.height ?? 0.5;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: theme.colorScheme.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.grey!.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.grey!.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            Grabber(
              headerBuilder: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .grey!
                              .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    widget.headerBuilder ?? const SizedBox(),
                  ],
                ),
              ),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if (details.primaryDelta != null) {
                  setState(() {
                    _sheetPosition -= details.primaryDelta! / _dragSensitivity;
                    if (_sheetPosition < 0.2) {
                      _sheetPosition = 0.2;
                    } else if (_sheetPosition > 1) {
                      _sheetPosition = 1;
                    }
                  });
                }
              },
            ),
            widget.widgetBuilder ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
    required this.headerBuilder,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final Widget headerBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.topCenter,
          child: headerBuilder,
        ),
      ),
    );
  }
}
