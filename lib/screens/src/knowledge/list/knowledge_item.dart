import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/screens.dart';

class KnowledgeItem extends StatefulWidget {
  final Content knowledge;

  KnowledgeItem({required this.knowledge}) : super(key: ValueKey(knowledge));

  @override
  _KnowledgeItemState createState() => _KnowledgeItemState();
}

class _KnowledgeItemState extends BaseState<KnowledgeItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushScreen(PageIntent(
            screen: KnowledgeDetailScreen, bundle: Bundle(widget.knowledge)));
      },
      child: Container(
        padding: const EdgeInsets.all(Dimens.px16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.px0, right: Dimens.px16),
                    child: KayleeText(
                      widget.knowledge.name,
                      maxLines: 1,
                      style: TextStyles.normal16W400,
                    ),
                  ),
                ),
                KayleeText.normal16W400(
                  widget.knowledge.createdAt
                          ?.toFormatString(pattern: 'dd/MM') ??
                      '',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px8),
              child: KayleeText.hint16W400(
                widget.knowledge.description,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
