import 'dart:async';
import 'dart:ui';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/home/tabs/home/bloc/scroll_offset_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/user_name.dart';
import 'package:kaylee/utils/utils.dart';

class HomeMenu extends StatefulWidget {
  static Widget newInstance() => BlocProvider<HomeMenuBloc>(
        create: (context) => HomeMenuBloc(),
        child: const HomeMenu._(),
      );

  const HomeMenu._();

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends BaseState<HomeMenu> {
  ScrollOffsetBloc get _scrollOffsetBloc => context.bloc<ScrollOffsetBloc>()!;

  UserInfo? get userInfo => context.user.getUserInfo().userInfo;

  HomeMenuBloc get _homeMenuBloc => context.bloc<HomeMenuBloc>()!;
  late StreamSubscription _sub;

  final gradientBg = Container(
      decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        ColorsRes.color1,
        ColorsRes.button,
        ColorsRes.button,
        ColorsRes.color1,
      ],
      stops: [0, 0.4, 0.7, 1],
      begin: Alignment(0.50, -0.87),
      end: Alignment(-0.50, 0.87),
      // angle: 210,
      // scale: undefined,
    ),
  ));

  @override
  void initState() {
    super.initState();

    _sub = _scrollOffsetBloc.stream.listen((offset) {
      _homeMenuBloc.updateHomeMenuState(
          offset: offset, collapseMenuHeight: collapseMenuHeight);
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo?.role == UserRole.employee) {
      _homeMenuBloc
          .updateMenuHeight(homeMenuItemHeight * 2 + Dimens.px56 + Dimens.px7);
    }
    return Stack(children: [
      Material(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.px20),
          bottomRight: Radius.circular(Dimens.px20),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: Dimens.px10,
        color: Colors.transparent,
        child: Stack(children: [
          BlocBuilder<HomeMenuBloc, HomeMenuState>(
            builder: (context, state) {
              return SizedBox(height: state.height, child: gradientBg);
            },
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 70, sigmaX: 100),
            child: StreamBuilder<bool>(
              stream: _homeMenuBloc.backGroundStateController.stream,
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: snapshot.data ?? false ? 0.6 : 0.3,
                  child: Container(
                    color: Colors.black,
                  ),
                );
              },
            ),
          ))
        ]),
      ),
      const Positioned.fill(
        child: UserName(),
      ),
      Positioned(
        child: NotificationButton.newInstance(),
        right: 0,
        top: Dimens.px24,
      )
    ]);
  }

  double get homeMenuItemWith =>
      (context.screenSize.width - Dimens.px16 * 2) / 4;

  double get homeMenuItemRatio => 86 / 76;

  double get homeMenuItemHeight => homeMenuItemWith / homeMenuItemRatio;

  double get collapseMenuHeight =>
      Dimens.px56 + Dimens.px16 * 2 + Dimens.px16 + Dimens.px20;
}

class HomeMenuBloc extends Cubit<HomeMenuState> {
  static const double menuHeight = 316;
  final backGroundStateController = BehaviorSubject<bool>();
  double? height;
  bool canUpdateHeight = true;

  HomeMenuBloc() : super(HomeMenuState(height: menuHeight)) {
    backGroundStateController.value = false;
  }

  @override
  Future<void> close() async {
    await backGroundStateController.close();
    return super.close();
  }

  void updateMenuHeight(double height) {
    if (this.height != null) return;
    this.height = menuHeight - height;
    updateHomeMenuState();
    canUpdateHeight = false;
  }

  void updateHomeMenuState({double offset = 0, double collapseMenuHeight = 0}) {
    if (!canUpdateHeight) return;
    //offset của listview
    final offs = offset;
    //appbar chỉ collapse tới khi offset của listview = height lúc expand - height lúc collpased
    final double scrollingDistance =
        (height ?? menuHeight) - collapseMenuHeight;
    //percent collapse của appbar khi user scroll
    final double collapsePercent =
        offs < scrollingDistance ? offs / scrollingDistance : 1;
    if (collapsePercent == 1 && !state.isCollapsed) {
      //khi appbar đã collapse và state của appbar trước đó ko phải là collapse
      state.isCollapsed = true;
      backGroundStateController.value = state.isCollapsed;
    } else if (collapsePercent < 1 && state.isCollapsed) {
      //khi appbar đang scroll để expand và state của appbar trước đó là collapse
      state.isCollapsed = false;
      backGroundStateController.value = false;
    }
    emit(HomeMenuState.copy(state
      ..menuRow2CollapsePercent =
          state.collapsePercent >= 0 && state.collapsePercent < 1
              ? 1 - state.collapsePercent
              : 1
      ..collapsePercent = collapsePercent
      ..offset = offs
      ..height = collapsePercent == 1
          ? collapseMenuHeight
          : (height ?? menuHeight) - offs));
  }
}

class HomeMenuState {
  late double collapsePercent;
  late double height;
  late double offset;
  late bool isCollapsed;
  late double menuRow2CollapsePercent;

  HomeMenuState(
      {this.collapsePercent = 0,
      this.height = 0,
      this.offset = 0,
      this.isCollapsed = false,
      this.menuRow2CollapsePercent = 1});

  HomeMenuState.copy(HomeMenuState old) {
    this
      ..collapsePercent = old.collapsePercent
      ..height = old.height
      ..offset = old.offset
      ..isCollapsed = old.isCollapsed
      ..menuRow2CollapsePercent = old.menuRow2CollapsePercent;
  }
}
