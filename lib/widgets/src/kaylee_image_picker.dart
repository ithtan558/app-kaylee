import 'dart:io';

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeImagePicker extends StatefulWidget {
  final String image;

  KayleeImagePicker({this.image});

  @override
  _KayleeImagePickerState createState() => new _KayleeImagePickerState();
}

class _KayleeImagePickerState extends BaseState<KayleeImagePicker> {
  File file;

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
    return Container(
      height: Dimens.px103 + Dimens.px16 + Dimens.px56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.px10),
              border: Border.fromBorderSide(
                BorderSide(color: ColorsRes.hintText),
              ),
            ),
            width: Dimens.px103,
            height: Dimens.px103,
            child: widget.image.isNullOrEmpty && file.isNull
                ? Center(
              child: Image.asset(
                Images.ic_image_holder,
                width: Dimens.px40,
                height: Dimens.px40,
              ),
            )
                : AspectRatio(
              aspectRatio: 1,
              child: file.isNotNull
                  ? Image.file(file)
                  : Image.network(
                widget.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: Dimens.px56,
            width: screenSize.width * 243 / 375,
            child: FlatButton(
              color: ColorsRes.button.withOpacity(0.8),
              padding: EdgeInsets.all(Dimens.px12),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.px10)),
              onPressed: () {
               showImagePickerDialog();
              },
              child: Row(
                children: [
                  Image.asset(
                    Images.ic_camera,
                    width: Dimens.px32,
                    height: Dimens.px32,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Dimens.px12),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: KayleeText(
                          Strings.chinhSuaHinhDaiDien,
                          style: TextStyles.normalWhite16W500,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

   showImagePickerDialog() {
     showModalBottomSheet(
         context: context,
         shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(Dimens.px5),
                 topRight: Radius.circular(Dimens.px5))),
         enableDrag: true,
         backgroundColor: Colors.transparent,
         isScrollControlled: true,
         builder: (context) {
           final width = (screenSize.width - 4 * Dimens.px16) / 3
           return GestureDetector(
             onTap: () {
               pop(PageIntent(context, null));
             },
             child: Container(
               color: Colors.transparent,
               child: DraggableScrollableSheet(
                 maxChildSize: 1,
                 expand: true,
                 builder: (c, scrollController) {
                   return Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(
                           Dimens.px5),
                       boxShadow: [
                         const BoxShadow(
                             color: Color(0x4c000000),
                             offset: Offset.zero,
                             blurRadius: Dimens.px20,
                             spreadRadius: 0)
                       ],
                     ),
                     child: Column(
                       children: [
                         Container(
                             width: scaleWidth(Dimens.px37),
                             height: Dimens.px5,
                             margin: const EdgeInsets.symmetric(
                                 vertical: Dimens.px16),
                             decoration: BoxDecoration(
                                 color: ColorsRes.textFieldBorder,
                                 borderRadius:
                                 BorderRadius.circular(Dimens.px3))),
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.all(
                                 Dimens.px16),
                             child: Row(
                               children: [

                               ],
                             ),
                           ),
                         )
                       ],
                     ),
                   );
                 },
               ),
             ),
           );
         },
         barrierColor: ColorsRes.dialogDimBg);
   }

}
