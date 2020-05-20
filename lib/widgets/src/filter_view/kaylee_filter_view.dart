import 'dart:math';

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeFilterView extends StatefulWidget {
  final Widget child;
  final String title;

  KayleeFilterView({this.title, this.child});

  @override
  _KayleeFilterViewState createState() => new _KayleeFilterViewState();
}

class _KayleeFilterViewState extends BaseState<KayleeFilterView> {
  final _filterViewController = _FilterViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_filterViewController.view._filterViewAnimController.isDismissed) {
          return true;
        } else {
          _filterViewController.view._filterViewAnimController.forward();
          return false;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              top: Dimens.px80 - Dimens.px8,
              child: SafeArea(
                top: true,
                child: widget.child ?? Container(),
              ),
            ),
            _FilterView(
              title: widget.title,
              controller: _filterViewController,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatefulWidget {
  final void Function(bool state) onClick;
  final AnimationController animController;

  _FilterButton({this.onClick, this.animController});

  @override
  __FilterButtonState createState() => __FilterButtonState();
}

class __FilterButtonState extends BaseState<_FilterButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    widget.animController.addListener(() {
      if (widget.animController.isDismissed) {
        isOpened = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px32,
      child: Material(
        borderRadius: BorderRadius.circular(Dimens.px5),
        color: ColorsRes.filterButton,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            if (!isOpened)
              widget.animController.forward(from: widget.animController.value);
            else
              widget.animController.reverse(from: widget.animController.value);
            isOpened = !isOpened;
            if (widget.onClick != null) {
              widget.onClick(isOpened);
            }
          },
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.px10),
                child: Image.asset(
                  Images.ic_options,
                  width: Dimens.px16,
                  height: Dimens.px16,
                ),
              ),
              Container(
                  width: Dimens.px1,
                  margin: const EdgeInsets.symmetric(vertical: Dimens.px2),
                  decoration: BoxDecoration(color: Colors.white)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.px4),
                child: AnimatedBuilder(
                  animation: widget.animController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: widget.animController.value * pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    Images.ic_filter_down,
                    width: Dimens.px24,
                    height: Dimens.px24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterViewController {
  _FilterViewState view;
}

class _FilterView extends StatefulWidget {
  final String title;

  final _FilterViewController controller;

  _FilterView({this.title, this.controller});

  @override
  _FilterViewState createState() => new _FilterViewState();
}

class _FilterViewState extends BaseState<_FilterView>
    with TickerProviderStateMixin {
  AnimationController _filterViewAnimController;

  @override
  void initState() {
    super.initState();
    widget.controller.view = this;
    _filterViewAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 180));
  }

  @override
  void dispose() {
    _filterViewAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: Dimens.px16,
            top: Dimens.px24,
            right: Dimens.px61 + Dimens.px16 * 2,
            child: SafeArea(
              top: true,
              child: Text(
                widget.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText2.copyWith(
                  fontSize: Dimens.px26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          _FilterList(
            animController: _filterViewAnimController,
          ),
          Positioned(
            child: SafeArea(
              top: true,
              child: _FilterButton(
                onClick: (state) {},
                animController: _filterViewAnimController,
              ),
            ),
            top: Dimens.px24,
            right: Dimens.px16,
          ),
        ],
      ),
    );
  }
}

class _FilterList extends StatefulWidget {
  final AnimationController animController;

  _FilterList({this.animController});

  @override
  _FilterListState createState() => new _FilterListState();
}

class _FilterListState extends BaseState<_FilterList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: widget.animController,
            builder: (context, child) {
              if (widget.animController.isDismissed) {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  widget.animController.reverse();
                },
                child: Container(
                  color: Color.lerp(Colors.transparent, ColorsRes.dialogDimBg,
                      widget.animController.value),
                  padding: EdgeInsets.only(top: Dimens.px56 + Dimens.px8),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: widget.animController,
            builder: (context, child) {
              if (widget.animController.isDismissed) {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimens.px56 + Dimens.px8),
                  child: Transform.scale(
                    child: Opacity(
                      child: child,
                      opacity: widget.animController.value,
                    ),
                    scale: widget.animController.value,
                    alignment: Alignment(5 / 6, -1),
                  ),
                ),
              );
            },
            child: _buildFilterList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterList() {
    return SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.only(
              right: Dimens.px8, left: Dimens.px8, bottom: Dimens.px8),
          child: Container(
            padding: EdgeInsets.all(Dimens.px16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.px10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FilterViewTextField(),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: Dimens.px16),
                    itemBuilder: (c, index) {
                      if (index == 0) {
                        return _WrapperFilter(
                          title: 'Chọn lọc',
                          isAll: true,
                          children: <Widget>[
                            KayleeFilterListItem(
                              title: 'Tất cả',
                              onTap: (isSelected) {},
                            ),
                          ],
                        );
                      }
                      return _WrapperFilter(
                        title: 'Theo địa điểm phục vụ',
                        children: <Widget>[
                          KayleeFilterListItem(
                            title: 'Tất cả',
                            onTap: (isSelected) {},
                          ),
                          KayleeFilterListItem(
                            title: 'Annam Spa & Fitness',
                            onTap: (isSelected) {},
                          ),
                          KayleeFilterListItem(
                            title: 'Princess Spa',
                            onTap: (isSelected) {},
                          ),
                          KayleeFilterListItem(
                            title: 'Ánh Dương Fitness & Spa',
                            onTap: (isSelected) {},
                          )
                        ],
                      );
                    },
                    itemCount: 4,
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: Dimens.px16,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _FilterViewTextField extends StatefulWidget {
  @override
  _FilterViewTextFieldState createState() => new _FilterViewTextFieldState();
}

class _FilterViewTextFieldState extends BaseState<_FilterViewTextField> {
  final tfController = TextEditingController();
  bool closeIsShowed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.px5),
        border: Border.all(width: Dimens.px1, color: ColorsRes.textFieldBorder),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: tfController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (text) {
          if (text.isNotEmpty && !closeIsShowed) {
            setState(() {
              closeIsShowed = !closeIsShowed;
            });
          }
        },
        style:  theme.textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: Dimens.px16, bottom: Dimens.px16, left: Dimens.px16),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: Strings.timDonHang,
            hintStyle: theme.textTheme.bodyText2.copyWith(
              color: ColorsRes.hintText,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                if (closeIsShowed) {
                  setState(() {
                    tfController.text = '';
                    closeIsShowed = !closeIsShowed;
                  });
                }
              },
              child: Icon(
                !closeIsShowed ? Icons.search : Icons.close,
                color: ColorsRes.hintText,
              ),
            )),
      ),
    );
  }
}

class _WrapperFilter extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final bool isAll;

  _WrapperFilter({this.children, this.title, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!title.isNullOrEmpty)
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(title,
                style: ScreenUtils.screenTheme(context)
                    .textTheme
                    .bodyText2
                    .copyWith(
                      fontSize: isAll ? Dimens.px16 : Dimens.px12,
                      fontWeight: isAll ? FontWeight.w500 : FontWeight.w400,
                    )),
          ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: Dimens.px16,
          spacing: Dimens.px16,
          children: <Widget>[if (!children.isNullOrEmpty) ...children],
        ),
      ],
    );
  }
}
