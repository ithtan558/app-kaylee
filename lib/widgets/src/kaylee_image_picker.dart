import 'dart:io';

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

enum KayleeImagePickerType { profile, banner }

class KayleeImagePicker extends StatefulWidget {
  final String image;
  final KayleeImagePickerType type;
  final void Function(File file) onImageSelect;

  KayleeImagePicker(
      {this.image,
      this.type = KayleeImagePickerType.profile,
      this.onImageSelect});

  @override
  State createState() {
    switch (type) {
      case KayleeImagePickerType.banner:
        return _KayleeBannerImagePickerState();
      default:
        return _KayleeProfileImagePickerState();
    }
  }
}

class _KayleeProfileImagePickerState extends BaseState<KayleeImagePicker> {
  File selectedFile;

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
            child: widget.image.isNullOrEmpty && selectedFile.isNull
                ? Center(
                    child: Image.asset(
                      Images.ic_image_holder,
                      width: Dimens.px40,
                      height: Dimens.px40,
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 1,
                    child: selectedFile.isNotNull
                        ? Image.file(selectedFile)
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
                showImagePickerDialog(
                  context: context,
                  images: [],
                  onSelect: (file) {
                    this.selectedFile = file;
                  },
                );
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
}

class _KayleeBannerImagePickerState extends BaseState<KayleeImagePicker> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 263,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.grey,
              child: Image.file(
                File(''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: Dimens.px16,
            left: Dimens.px16,
            child: Material(
              color: Colors.white.withOpacity(0.8),
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(Dimens.px10),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.px12),
                  child: Row(
                    children: [
                      Image.asset(
                        Images.ic_camera,
                        width: Dimens.px32,
                        height: Dimens.px32,
                        color: ColorsRes.hintText,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: Dimens.px8),
                        child: KayleeText.hint16W500(
                          Strings.capNhatAnhBia,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future showImagePickerDialog({BuildContext context,
  List<dynamic> images,
  void Function(File file) onSelect}) async {
  Future<void> handlePermission() async {
    if (await Permission.storage.isGranted) {
      final pickedFile =
      await ImagePicker().getImage(source: ImageSource.gallery);
      final selectedFile = File(pickedFile.path);
      if (onSelect.isNotNull) {
        onSelect(selectedFile);
      }
    } else if (await Permission.storage.isDenied) {
      print('[TUNG] ===> isDenied');
      await Permission.storage.request();
    } else if (await Permission.storage.isRestricted) {
      print('[TUNG] ===> isRestricted');
      await showKayleeGo2SettingDialog(context: context);
    } else if (await Permission.storage.isPermanentlyDenied) {
      print('[TUNG] ===> isPermanentlyDenied');
      await showKayleeGo2SettingDialog(context: context);
    } else if (await Permission.storage.isUndetermined) {
      print('[TUNG] ===> isUndetermined');
      await Permission.storage.request();
    }
  }

  await showKayleeBottomSheet(
    context,
    initialChildSize: 145 / 667,
    minChildSize: 145 / 667,
    builder: (c, scrollController) {
      return GridView.builder(
        padding: const EdgeInsets.only(
            left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: Dimens.px16,
            mainAxisSpacing: Dimens.px16),
        itemBuilder: (c, index) {
          if (index == 0)
            return _BorderWrapper(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.ic_image_holder,
                    width: Dimens.px24,
                    height: Dimens.px24,
                    color: ColorsRes.button1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimens.px8),
                    child: KayleeText.normal16W400(
                      Strings.taiTuDienThoai,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () async {
                await handlePermission();
              },
            );
          else
            return _BorderWrapper();
        },
        itemCount: (images?.length ?? 0) + 1,
      );
    },
  );
}

class _BorderWrapper extends StatelessWidget {
  final Widget child;
  final void Function() onTap;

  _BorderWrapper({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return KayleeInkwell(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
              BorderSide(color: ColorsRes.hintText, width: Dimens.px1)),
          borderRadius: BorderRadius.circular(Dimens.px10),
        ),
        child: child ?? Container(),
      ),
      onTap: onTap,
    );
  }
}
