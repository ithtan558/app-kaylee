import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class NotifyDetailScreen extends StatefulWidget {
  factory NotifyDetailScreen.newInstance() = NotifyDetailScreen._;

  NotifyDetailScreen._();

  @override
  _NotifyDetailScreenState createState() => new _NotifyDetailScreenState();
}

class _NotifyDetailScreenState extends BaseState<NotifyDetailScreen> {
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
    return Scaffold(
      appBar: KayleeAppBar(
        leading: FlatButton(
          shape: CircleBorder(),
          child: ImageIcon(
            AssetImage(Images.ic_close),
            color: ColorsRes.hintText,
            size: 44,
          ),
          onPressed: () {
            pop(PageIntent(context, null));
          },
        ),
        actions: <Widget>[
          Container(
            height: double.infinity,
            margin: EdgeInsets.only(right: Dimens.px16),
            alignment: Alignment.centerRight,
            child: HyperLinkText(
              text: Strings.xoa,
              textStyle: TextStyles.hyper16W500,
              onTap: () {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.px16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              child: KayleeText.normal16W500(
                'A Beginners Guide To Chinese Cookery',
              ),
              padding: const EdgeInsets.only(bottom: Dimens.px16),
            ),
            KayleeText.hint16W400(
              'Chopped, sliced or wedged, hard-cooked eggs are the basis of egg salad and add protein and a happy glow to tossed and composed salads and casseroles. Chopped yolks and whites comprise Eggs Goldenrod and Polonaise Sauce. Whole hard-cooked eggs become comforting, familiar deviled eggs or zingy, newly rediscovered pickled eggs. Simply sprinkled with an herb or more fancily coated in sausage for Scotch eggs, hard-cooked eggs are nature’s own hand-held snack food. With a supply of hard-cooked eggs on hand, you’re ready for almost any meal occasion.\n\nHard-cooked eggs are often incorrectly called hard-boiled eggs. Yes, the cooking water must come to a boil. But, you’ll get more tender, less rubbery eggs without a green ring around the yolk and you’ll have less breakage if you turn off the heat or remove the pan from the burner, allowing the eggs to cook gently in hot water.\n\nVery fresh eggs may be difficult to peel. The fresher the eggs, the more the shell membranes cling tenaciously to the shells. The simplest method for easy peeling is to buy and refrigerate eggs a week to 10 days in advance of hard cooking. This brief “breather” allows the eggs to take in air which helps separate the membranes from the shell. 1. Place eggs in single layer in saucepan. Add enough tap water to come at least 1 inch above eggs.\n\n2. Cover. Quickly bring just to boiling. Turn off heat. 3. If necessary, remove pan from burner to prevent further boiling. Let eggs stand, covered, in the hot water about 15 minutes for Large eggs (12 minutes for Medium, 18 for Extra Large.)\n\n4. Immediately run cold water over eggs or place them in ice water (not standing water) until completely cooled. Once cooled, refrigerate eggs in their shells and use within one week of cooking or peel and use immediately.\n\n5. To remove shell, crackle it by tapping gently until a fine network of lines appears all over the shell.\n\n6. Roll egg between hands to loosen shell.\n\n7. Peel, starting at large end. Hold egg under running cold water or dip in bowl of water to help ease off shell. 8. To segment eggs evenly, use an egg slicer or wedger. For chopped eggs, rotate a sliced egg 90 degree in a slicer and slice again. Or chop eggs with a sharp pastry blender in a bowl. Draw down a wedger’s wires only partway to open an egg to hold a stuffing or resemble a flower.',
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
