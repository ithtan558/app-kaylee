import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFilterPopUpView extends StatefulWidget {
  final KayleeAppBar appBar;
  final Widget body;
  final Widget floatingActionButton;
  final Widget filterList;
  final Widget filterTags;

  KayleeFilterPopUpView(
      {this.appBar,
      this.body,
      this.floatingActionButton,
      this.filterList,
      this.filterTags});

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
    return WillPopScope(
      onWillPop: () async {
        if (filterViewController.isShowed) {
          filterViewController.hideFilter();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          if (filterViewController.isShowed) {
            filterViewController.hideFilter();
          }
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
                      filterViewController: filterViewController,
                    ),
                    Expanded(
                      child: Container(
                        height: Dimens.px32,
                        child: widget.filterTags ?? Container(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    widget.body ??
                        Container(
                          color: Colors.transparent,
                        ),
                    Positioned(
                      child: widget.floatingActionButton ?? Container(),
                      right: Dimens.px24,
                      bottom: Dimens.px24,
                    ),
                    _FilterList(
                      controller: filterViewController,
                      list: widget.filterList,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatefulWidget {
  final _FilterViewController filterViewController;

  _FilterButton({this.filterViewController});

  @override
  _FilterButtonState createState() => new _FilterButtonState();
}

class _FilterButtonState extends BaseState<_FilterButton> {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    widget.filterViewController?.button = this;
  }

  void showFilter() {
    isOpened = !isOpened;
    setState(() {});
  }

  void hideFilter() {
    isOpened = !isOpened;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.filterViewController.isHidden)
          widget.filterViewController?.showFilter();
        else
          widget.filterViewController?.hideFilter();
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

  final Widget list;

  _FilterList({this.controller, this.list});

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
      child: AnimatedBuilder(
        animation: animController,
        builder: (context, child) {
          if (animController.isDismissed) {
            return Container();
          }
          return GestureDetector(
            onTap: () {
              //chỗ này để tap lên ko bị close filter
              //ko đc bỏ
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
        child: widget.list ?? Container(),
      ),
    );
  }
}

class _FilterViewController {
  _FilterListState view;
  _FilterButtonState button;

  void hideFilter() {
    view.hideFilter();
    button.hideFilter();
  }

  void showFilter() {
    view.showFilter();
    button.showFilter();
  }

  bool get isShowed => view?.animController?.isCompleted ?? false;

  bool get isHidden => view?.animController?.isDismissed ?? false;
}
