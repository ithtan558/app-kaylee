import 'package:core_plugin/core_plugin.dart' hide Path;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_flat_button.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeDateFilterController {
  DateTime value;

  KayleeDateFilterController({this.value});
}

class KayleeDateFilter extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;
  final KayleeDateFilterController controller;

  KayleeDateFilter({this.onChanged, @required this.controller})
      : assert(controller.isNotNull);

  @override
  _KayleeDateFilterState createState() => new _KayleeDateFilterState();
}

class _KayleeDateFilterState extends BaseState<KayleeDateFilter> {
  PageController pageController;
  DateTime selectedDate;

  int get currentDay => pageController.page.toInt() + 1;

  @override
  void initState() {
    super.initState();
    widget.controller.value ??= DateTime.now();
    pageController = PageController(
        keepPage: false,
        viewportFraction: 1 / 7,
        initialPage: widget.controller.value.day - 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: Dimens.px16,
              right: Dimens.px16,
              top: Dimens.px8,
              bottom: Dimens.px3),
          child: Column(
            children: [
              KayleeDateFilterButton(
                selectedDate: widget.controller.value,
                onTap: () async {
                  await showPickerPopup(
                      context: context,
                      onDone: () {
                        if (selectedDate.isNotNull) {
                          widget.controller.value = selectedDate;
                          selectedDate = null;
                          setState(() {});
                        }
                        widget.onChanged?.call(widget.controller.value);
                      },
                      onDismiss: () {
                        selectedDate = null;
                        setState(() {});
                      },
                      builder: (context) {
                        return KayleeDatePicker(
                          maximumDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              findMaxDate(DateTime.now())),
                          initialDateTime: widget.controller.value,
                          mode: KayleeDatePickerMode.monthYear,
                          onDateTimeChanged: (changed) {
                            int maxDay = findMaxDate(changed);
                            final current =
                                currentDay > maxDay ? maxDay : currentDay;
                            selectedDate =
                                DateTime(changed.year, changed.month, current);
                          },
                          backgroundColor: Colors.white,
                        );
                      });
                  return true;
                },
              ),
              CustomPaint(
                painter: _TriangleClip(),
                size: Size(Dimens.px6, Dimens.px5),
              )
            ],
          ),
        ),
        Container(
          height: Dimens.px56,
          alignment: Alignment.center,
          child: Stack(alignment: Alignment.center, children: [
            Container(
              height: Dimens.px48,
              color: ColorsRes.labelDivider,
            ),
            Container(
              width: Dimens.px56,
              height: Dimens.px56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.px5),
                border: const Border.fromBorderSide(
                  BorderSide(
                    color: ColorsRes.hyper,
                    width: Dimens.px2,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                      color: ColorsRes.shadow,
                      offset: Offset(0, 1),
                      blurRadius: Dimens.px5,
                      spreadRadius: 0)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              height: Dimens.px48,
              child: PageView.builder(
                onPageChanged: (index) {
                  final date = widget.controller.value;
                  widget.controller.value =
                      DateTime(date.year, date.month, index + 1);
                  widget.onChanged?.call(widget.controller.value);
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: KayleeText.normal16W400(
                      '${index + 1}',
                      maxLines: 1,
                    ),
                  );
                },
                dragStartBehavior: DragStartBehavior.start,
                itemCount: findMaxDate(widget.controller.value),
                scrollDirection: Axis.horizontal,
                controller: pageController,
              ),
            ),
          ]),
        )
      ],
    );
  }

  int findMaxDate(DateTime minDate, {int max = 31}) {
    final maxDate = DateTime(minDate.year, minDate.month, max);
    if (maxDate.month > minDate.month) {
      return findMaxDate(minDate, max: max - 1);
    }
    return maxDate.day;
  }
}

class _TriangleClip extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()..color = ColorsRes.hyper;
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
