import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/notification/detail/notify_detail_screen.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotifyItem extends StatefulWidget {
  final String index;
  final Function() onDeleted;
  final Function() onTap;
  final models.Notification notification;

  NotifyItem({this.index, this.onDeleted, this.onTap, this.notification});

  @override
  _NotifyItemState createState() => new _NotifyItemState();
}

class _NotifyItemState extends BaseState<NotifyItem> {
  bool get isRead =>
      widget.notification.status == models.NotificationStatus.read;

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
      key: ValueKey(widget.notification),
      onDismissed: (_) {
        if (widget.onDeleted != null) {
          widget.onDeleted?.call();
        }
      },
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          pushScreen(PageIntent(
              screen: NotifyDetailScreen,
              bundle: Bundle(
                  models.Notification.fromJson(widget.notification.toJson()))));
          if (!isRead) {
            setState(() {
              widget.notification.status = models.NotificationStatus.read;
            });
          }
          widget.onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(Dimens.px16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        widget.notification.title,
                        maxLines: 1,
                        style: isRead
                            ? TextStyles.normal16W400
                            : TextStyles.button16W500,
                      ),
                    ),
                  ),
                  isRead
                      ? KayleeText.normal16W400(
                          widget.notification.date,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                      : KayleeText.normal16W500(
                          widget.notification.date,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px8),
                child: KayleeText(
                  widget.notification.description.plus('\n'),
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
