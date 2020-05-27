import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/notification/detail/notify_detail_screen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class NotifyItem extends StatefulWidget {
  final String index;
  final Function(dynamic item) onDeleted;
  final Function() onTap;

  NotifyItem(this.index, {this.onDeleted, this.onTap});

  @override
  _NotifyItemState createState() => new _NotifyItemState();
}

class _NotifyItemState extends BaseState<NotifyItem> {
  bool isRead = false;

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
    return KayleeDismissible(
      key: ValueKey(widget.index),
      onDismissed: (_) {
        if (widget.onDeleted != null) {
          widget.onDeleted(widget.index);
        }
      },
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          pushScreen(PageIntent(context, NotifyDetailScreen));
          if (widget.onTap.isNotNull) {
            if (!isRead) {
              setState(() {
                isRead = !isRead;
              });
            }
            widget.onTap();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(Dimens.px16),
          child: Column(
            children: [
              Row(
                children: [
                  if (!isRead)
                    Container(
                      width: Dimens.px16,
                      height: Dimens.px16,
                      decoration: BoxDecoration(
                          color: ColorsRes.button, shape: BoxShape.circle),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isRead ? 0 : Dimens.px8, right: Dimens.px16),
                      child: KayleeText(
                        'A Beginners Guide To Chinese Cookery',
                        maxLines: 1,
                        style: isRead
                            ? TextStyles.normal16W400
                            : TextStyles.button16W500,
                      ),
                    ),
                  ),
                  KayleeDateTimeText.dayMonth(
                    0,
                    textAlign: TextAlign.end,
                    textStyle: isRead
                        ? TextStyles.normal16W400
                        : TextStyles.button16W500,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px8),
                child: KayleeText(
                  'If you are considering purchasing a new grill, or barbecue, you will be faced with a multitude',
                  maxLines: 2,
                  style:
                      isRead ? TextStyles.hint16W400 : TextStyles.button16W400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
