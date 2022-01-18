import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeCountdown extends StatefulWidget {
  final DateTime endTime;

  const KayleeCountdown({
    Key? key,
    required this.endTime,
  }) : super(key: key);

  @override
  State<KayleeCountdown> createState() => _KayleeCountdownState();
}

class _KayleeCountdownState extends State<KayleeCountdown> {
  Timer? _timer;
  late ValueNotifier<Duration> _timerNotifier;

  @override
  void initState() {
    super.initState();
    _calculateDuration();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timerNotifier.dispose();
  }

  void _restart() {
    _timer?.cancel();
    _calculateDuration();
  }

  @override
  void didUpdateWidget(covariant KayleeCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endTime != widget.endTime) {
      _restart();
    }
  }

  void _calculateDuration() {
    var duration = widget.endTime.difference(DateTime.now());
    if (duration.isNegative) {
      duration = Duration.zero;
    }
    _timerNotifier = ValueNotifier(duration);
    if (_timerNotifier.value > Duration.zero) {
      _startTimer();
    }
  }

  void _startTimer() {
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      _timerNotifier.value -= period;
      if (_timerNotifier.value <= Duration.zero) {
        _timerNotifier.value = Duration.zero;
        return timer.cancel();
      }
    });
  }

  final _pattern = '00';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsRes.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.px8).copyWith(right: Dimens.px12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KayleeText.normal16W500(
              Strings.ketThucSau,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildTimeChangeBuilder(
                      builder: (duration) => _buildTime(
                          duration.hours.floorToDouble().format(_pattern))),
                  KayleeText.normal16W500(
                    Strings.gio,
                    maxLines: 1,
                  ),
                  _buildTimeChangeBuilder(
                      builder: (duration) => _buildTime(
                          duration.minutes.floorToDouble().format(_pattern))),
                  KayleeText.normal16W500(
                    Strings.phut,
                    maxLines: 1,
                  ),
                  _buildTimeChangeBuilder(
                      builder: (duration) => _buildTime(
                          duration.seconds.floorToDouble().format(_pattern))),
                  KayleeText.normal16W500(
                    Strings.giay,
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTime(String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
      child: Material(
        color: ColorsRes.hyper,
        borderRadius: BorderRadius.circular(Dimens.px5),
        clipBehavior: Clip.antiAlias,
        child: SizedBox.square(
          dimension: Dimens.px32,
          child: Center(child: KayleeText.normalWhite16W500(time)),
        ),
      ),
    );
  }

  Widget _buildTimeChangeBuilder(
      {required Widget Function(Duration duration) builder}) {
    return ValueListenableBuilder<Duration>(
      valueListenable: _timerNotifier,
      builder: (context, value, child) => builder(value),
    );
  }
}
