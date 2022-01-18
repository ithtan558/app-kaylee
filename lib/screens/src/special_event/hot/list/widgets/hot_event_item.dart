import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';

class HotEventItem extends StatelessWidget {
  final Content content;

  const HotEventItem({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
            PageIntent(screen: HotEventDetailScreen, bundle: Bundle(content)));
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.px16),
              child: Row(
                children: [
                  Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(Dimens.px5),
                    color: Colors.transparent,
                    child: KayleeNetworkImage.square(
                      content.supplier?.image ?? '',
                      size: Dimens.px32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: Dimens.px8),
                    child: KayleeText.normal16W500(
                      content.supplier?.name ?? '',
                      maxLines: 1,
                    ),
                  ))
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 375 / 240,
              child: KayleeNetworkImage.normal(
                content.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.px16)
                  .copyWith(bottom: Dimens.px0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KayleeText.normal16W500(
                    content.name,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimens.px8, bottom: Dimens.px16),
                    child: KayleeText.hint16W400(
                      content.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset(
                              Images.icEye,
                              width: Dimens.px24,
                              height: Dimens.px24,
                            ),
                            KayleeText.hint16W400(content.views.toString()),
                            Container(
                              width: 1,
                              height: Dimens.px10,
                              color: ColorsRes.hintText,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: Dimens.px8),
                            ),
                            KayleeText.hint16W400(time),
                          ],
                        ),
                      ),
                      const HyperLinkText(text: Strings.xemToanBo),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String get time {
    if (content.createdAt.isNull) return '';
    final duration = DateTime.now().difference(content.createdAt!);

    if (duration == Duration.zero) return Strings.vuaXong;

    if (duration > Duration.zero && duration < const Duration(minutes: 1)) {
      return '${duration.inSeconds} ${Strings.giayTruoc}';
    }
    if (duration >= const Duration(minutes: 1) &&
        duration < const Duration(hours: 1)) {
      return '${duration.inMinutes} ${Strings.phutTruoc}';
    }
    if (duration >= const Duration(hours: 1) &&
        duration < const Duration(days: 1)) {
      return '${duration.inHours} ${Strings.gioTruoc}';
    }
    if (duration >= const Duration(days: 1) &&
        duration < const Duration(days: 30)) {
      return '${duration.inDays} ${Strings.ngayTruoc}';
    }
    return content.createdAt!.toFormatString(pattern: 'dd/MM/yyyy');
  }
}
