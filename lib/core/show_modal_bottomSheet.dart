// ignore: file_names
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/utils/logger.dart';

Future<void> showModalBottomSheetCustom(BuildContext context, {Widget? widgetBuilder, Widget? headerBuilder}) async {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      elevation: 0.2,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggleBottomSheetCustom(
            widgetBuilder: widgetBuilder,
            headerBuilder: headerBuilder,
          ));
}

class DraggleBottomSheetCustom extends StatefulWidget {
  const DraggleBottomSheetCustom({
    super.key,
    this.widgetBuilder,
    this.headerBuilder,
  });

  final Widget? widgetBuilder;
  final Widget? headerBuilder;

  @override
  State<DraggleBottomSheetCustom> createState() => _DraggleBottomSheetCustomState();
}

class _DraggleBottomSheetCustomState extends State<DraggleBottomSheetCustom> {
  double _sheetPosition = 0.55;
  final double _dragSensitivity = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: _sheetPosition,
          minChildSize: 0.2,
          maxChildSize: 1,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                                color: Theme.of(context).colorScheme.grey!.withOpacity(0.6),
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
                  Expanded(
                    child: widget.widgetBuilder ?? const SizedBox(),
                  ),
                ],
              ),
            );
          },
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
