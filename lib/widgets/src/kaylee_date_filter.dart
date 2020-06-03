import 'package:core_plugin/core_plugin.dart' hide Path;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:kaylee/widgets/src/kaylee_flat_button.dart';

class KayleeDateFilter extends StatefulWidget {
  @override
  _KayleeDateFilterState createState() => new _KayleeDateFilterState();
}

class _KayleeDateFilterState extends BaseState<KayleeDateFilter> {
  PageController pageController;
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: false, viewportFraction: 1 / 7);
    selectedDate = DateTime.now();
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
                selectedDate: selectedDate,
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      barrierColor: ColorsRes.shadow.withOpacity(0.1),
                      builder: (context) {
                        return Container(
                          height: 215.0 + Dimens.px44,
                          decoration: BoxDecoration(
                            color: ColorsRes.dialogNavigate,
                            boxShadow: [
                              BoxShadow(
                                  color: ColorsRes.shadow,
                                  offset: Offset(0, -0.5),
                                  blurRadius: 0,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: Dimens.px44,
                                  alignment: Alignment.centerRight),
                              Container(
                                height: 215.0,
                                child: KayleeMonthYearPicker(
                                  maximumDate: DateTime(DateTime.now().year,
                                      DateTime.now().month, 1),
                                  initialDateTime: selectedDate,
                                  onDateTimeChanged: (changed) {
                                    setState(() {
                                      selectedDate = changed;
                                    });
                                  },
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
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
                itemCount: 31,
                scrollDirection: Axis.horizontal,
                controller: pageController,
              ),
            ),

          ]),
        )
      ],
    );
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
