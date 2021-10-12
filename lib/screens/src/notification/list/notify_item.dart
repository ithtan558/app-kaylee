import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/screens/src/notification/detail/notify_detail_screen.dart';

class NotifyItem extends StatefulWidget {
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;
  final models.Notification notification;

  NotifyItem({this.onDeleted, this.onTap, required this.notification})
      : super(key: ValueKey(notification));

  @override
  _NotifyItemState createState() => _NotifyItemState();
}

class _NotifyItemState extends BaseState<NotifyItem> {
  bool get isRead =>
      widget.notification.status == models.NotificationStatus.read;

  @override
  Widget build(BuildContext context) {
    return KayleeDismissible(
      key: widget.key!,
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
                      decoration: const BoxDecoration(
                          color: ColorsRes.button, shape: BoxShape.circle),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isRead ? 0 : Dimens.px8, right: Dimens.px16),
                      child: KayleeText(
                        widget.notification.title ?? '',
                        maxLines: 1,
                        style: isRead
                            ? TextStyles.normal16W400
                            : TextStyles.button16W500,
                      ),
                    ),
                  ),
                  isRead
                      ? KayleeText.normal16W400(
                    widget.notification.date ?? '',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                      : KayleeText.normal16W500(
                    widget.notification.date ?? '',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px8),
                child: KayleeText(
                  widget.notification.description ?? '',
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
