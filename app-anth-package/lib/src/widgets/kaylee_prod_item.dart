import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeProdItemView extends StatelessWidget {
  final Widget child;

  factory KayleeProdItemView.canTap(
          {required KayleeProdItemData data, VoidCallback? onTap}) =>
      KayleeProdItemView(
          child: KayleeInkwell(
        child: KayleeProdItem(
          data: data,
        ),
        onTap: onTap,
      ));

  factory KayleeProdItemView.canSelect({
    required KayleeProdItemData data,
    bool selected = false,
    void Function(bool selected)? onSelect,
  }) =>
      KayleeProdItemView(
        child: _SelectingProItemView(
          data: data,
          onSelect: onSelect,
          selected: selected,
        ),
      );

  const KayleeProdItemView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _SelectingProItemView extends StatefulWidget {
  final void Function(bool selected)? onSelect;
  final KayleeProdItemData data;
  final bool selected;

  const _SelectingProItemView(
      {required this.data, this.onSelect, this.selected = false});

  @override
  _SelectingProItemViewState createState() => _SelectingProItemViewState();
}

class _SelectingProItemViewState extends BaseState<_SelectingProItemView>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> scaleAnim;
  late Animation<double> opacityAnim;
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.selected;
    animController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 550),
        reverseDuration: const Duration(milliseconds: 100));
    scaleAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear));
    opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animController,
        curve: Interval(100 / animController.duration!.inMilliseconds,
            170 / animController.duration!.inMilliseconds,
            curve: Curves.easeIn),
      ),
    );
    if (isSelected) {
      animController.value = 1;
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animController.isCompleted) {
          animController.reverse();
        } else if (animController.isDismissed) {
          animController.forward();
        }
        isSelected = !isSelected;
        widget.onSelect?.call(isSelected);
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(children: [
          Positioned.fill(
            child: KayleeProdItem(
              data: widget.data,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedBuilder(
              animation: animController,
              builder: (context, child) {
                if (animController.isDismissed) return Container();
                return Opacity(
                  opacity: opacityAnim.value,
                  child: Transform.scale(
                    child: child,
                    alignment: Alignment.center,
                    scale: scaleAnim.value,
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 48 / 103,
                heightFactor: 48 / 103,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorsRes.hyper,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: ColorsRes.shadow,
                          offset: Offset(0, 2),
                          blurRadius: Dimens.px10,
                          spreadRadius: 0)
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const FractionallySizedBox(
                    widthFactor: 20 / 48,
                    heightFactor: 16 / 48,
                    alignment: Alignment.center,
                    child: ImageIcon(
                      AssetImage(
                        IconAssets.icTick,
                        package: anthPackage,
                      ),
                      color: Colors.white,
                      size: Dimens.px20,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class KayleeProdItemData {
  final String? image;
  final String? name;
  final dynamic price;

  KayleeProdItemData({this.image, this.name, this.price});
}

class KayleeProdItem extends StatelessWidget {
  final KayleeProdItemData data;

  KayleeProdItem({required this.data}) : super(key: ValueKey(data));

  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      itemHeight: double.infinity,
      child: KayleeImageInfoLayout(
        imageView: CachedNetworkImage(
          imageUrl: data.image ?? '',
          fit: BoxFit.cover,
        ),
        infoView: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: Dimens.px7, right: Dimens.px5),
              child: KayleeText.normal16W500(
                data.name ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px4),
              child: KayleePriceText.normal(
                data.price,
                textStyle: TextStyles.hyper16W400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
