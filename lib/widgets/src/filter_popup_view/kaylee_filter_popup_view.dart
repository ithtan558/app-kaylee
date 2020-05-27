import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeFilterPopUpView extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Widget body;

  KayleeFilterPopUpView({this.appBar, this.body});

  @override
  _KayleeFilterPopUpViewState createState() =>
      new _KayleeFilterPopUpViewState();
}

class _KayleeFilterPopUpViewState extends BaseState<KayleeFilterPopUpView> {
  final filterViewController = _FilterViewController();

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
    return GestureDetector(
      onTap: () {
        filterViewController.view.hideFilter();
      },
      child: Scaffold(
        appBar: widget.appBar,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.px16, vertical: Dimens.px8),
              child: Row(
                children: [
                  _FilterButton(
                    onTap: (state) {
                      if (filterViewController.view.isHidden)
                        filterViewController.view.showFilter();
                      else
                        filterViewController.view.hideFilter();
                    },
                    filterViewController: filterViewController,
                  )
                ],
              ),
            ),
            Expanded(
                child: Stack(children: [
              widget.body ??
                  Container(
                    color: Colors.transparent,
                  ),
              _FilterList(
                controller: filterViewController,
              ),
            ]))
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatefulWidget {
  final void Function(bool state) onTap;
  final _FilterViewController filterViewController;

  _FilterButton({this.onTap, this.filterViewController});

  @override
  __FilterButtonState createState() => new __FilterButtonState();
}

class __FilterButtonState extends BaseState<_FilterButton> {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    widget.filterViewController?.view?.animController?.addListener(() {
      print('[TUNG] ===> ');
      if (widget.filterViewController.view.animController.status ==
              AnimationStatus.reverse &&
          isOpened) {
        setState(() {
          isOpened = !isOpened;
        });
      } else if (widget.filterViewController.view.animController.status ==
              AnimationStatus.forward &&
          !isOpened) {
        setState(() {
          isOpened = !isOpened;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isOpened = !isOpened;
        if (widget.onTap != null) {
          widget.onTap(isOpened);
        }
        setState(() {});
      },
      child: Container(
        width: Dimens.px32,
        height: Dimens.px32,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(isOpened ? Dimens.px4 : Dimens.px8),
        decoration: BoxDecoration(
            color: ColorsRes.textFieldBorder, shape: BoxShape.circle),
        child: SizedBox(
          child: ImageIcon(
            AssetImage(
              isOpened ? Images.ic_close : Images.ic_filter,
            ),
            color: isOpened ? Colors.white : ColorsRes.button,
          ),
        ),
      ),
    );
  }
}

class _FilterList extends StatefulWidget {
  final _FilterViewController controller;

  _FilterList({this.controller});

  @override
  _FilterListState createState() => new _FilterListState();
}

class _FilterListState extends BaseState<_FilterList>
    with SingleTickerProviderStateMixin {
  AnimationController animController;

  @override
  void initState() {
    super.initState();
    widget.controller?.view = this;
    animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 180));
  }

  bool get isShowed => animController.isCompleted;

  bool get isHidden => animController.isDismissed;

  void showFilter() {
    animController.forward(from: animController.value);
  }

  void hideFilter() {
    animController.reverse(from: animController.value);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: Dimens.px16,
      right: Dimens.px16,
      bottom: Dimens.px16,
      child: Container(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            if (animController.isDismissed) {
              return Container();
            }
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Transform.scale(
                child: Opacity(
                  child: child,
                  opacity: animController.value,
                ),
                scale: animController.value,
                alignment: Alignment.topLeft,
              ),
            );
          },
          child: _buildFilterList(),
        ),
      ),
    );
  }

  Widget _buildFilterList() {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.px10),
        boxShadow: [
          BoxShadow(
              color: ColorsRes.shadow,
              offset: Offset(0, 5),
              blurRadius: Dimens.px10,
              spreadRadius: 0)
        ],
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.px10),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.only(
              left: Dimens.px24,
              right: Dimens.px24,
              top: Dimens.px24,
              bottom: Dimens.px16),
          itemBuilder: (c, index) {
            if (index == 0) {
              return WrapperFilter(
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
            return WrapperFilter(
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
    );
  }
}

class _FilterViewController {
  _FilterListState view;
}
