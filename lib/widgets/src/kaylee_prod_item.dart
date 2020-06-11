import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeProdItemView extends StatelessWidget {
  final Widget child;

  factory KayleeProdItemView.canTap(
          {@required KayleeProdItemData data, void Function() onTap}) =>
      KayleeProdItemView(
          child: KayleeInkwell(
        child: KayleeProdItem(
          data: data,
        ),
        onTap: onTap,
      ));

  factory KayleeProdItemView.canSelect(
          {@required KayleeProdItemData data,
          void Function(bool selected) onSelect}) =>
      KayleeProdItemView(
        child: _SelectingProItemView(
          data: data,
          onSelect: onSelect,
        ),
      );

  KayleeProdItemView({@required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _SelectingProItemView extends StatefulWidget {
  final Function(bool selected) onSelect;
  final KayleeProdItemData data;

  _SelectingProItemView({@required this.data, this.onSelect});

  @override
  _SelectingProItemViewState createState() => _SelectingProItemViewState();
}

class _SelectingProItemViewState extends State<_SelectingProItemView>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> scaleAnim;
  Animation<double> opacityAnim;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 550),
        reverseDuration: Duration(milliseconds: 100));
    scaleAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear));
    opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animController,
        curve: Interval(100 / animController.duration.inMilliseconds,
            170 / animController.duration.inMilliseconds,
            curve: Curves.easeIn),
      ),
    );
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
                  child: FractionallySizedBox(
                    widthFactor: 20 / 48,
                    heightFactor: 16 / 48,
                    alignment: Alignment.center,
                    child: ImageIcon(
                      AssetImage(Images.ic_tick),
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
  final String image;
  final String name;
  final dynamic price;

  KayleeProdItemData({this.image, this.name, this.price});
}

class KayleeProdItem extends StatelessWidget {
  final KayleeProdItemData data;

  KayleeProdItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      itemHeight: double.infinity,
      child: KayleeImageInfoLayout(
        imageView: Image.network(
          data.image,
          fit: BoxFit.cover,
        ),
        infoView: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KayleeText.normal16W500(
              data.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
