import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

enum KayleeImagePickerType { profile, banner }

class ImagePickerController {
  File image;

  ///image url from existed things;
  String existedImageUrl;
}

class KayleeImagePicker extends StatefulWidget {
  final KayleeImagePickerType type;
  final List<String> oldImages;
  final ImagePickerController controller;

  final void Function() onImageSelect;

  KayleeImagePicker({
    this.type = KayleeImagePickerType.profile,
    this.onImageSelect,
    this.oldImages = const [],
    this.controller,
  });

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
  void didUpdateWidget(KayleeImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px103 + Dimens.px16 + Dimens.px56,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Dimens.px103,
            height: Dimens.px103,
            child: Material(
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.px10),
                side: BorderSide(color: ColorsRes.hintText),
              ),
              child: widget.controller?.existedImageUrl.isNullOrEmpty &&
                      selectedFile.isNull
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
                          ? Image.file(
                              selectedFile,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  widget.controller?.existedImageUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                    ),
            ),
          ),
          Container(
            height: Dimens.px56,
            width: context.screenSize.width * 243 / 375,
            child: FlatButton(
              color: ColorsRes.button.withOpacity(0.8),
              padding: EdgeInsets.all(Dimens.px12),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.px10)),
              onPressed: () {
                showImagePickerDialog(
                  context: context,
                  images: widget.oldImages,
                  selectedExistedImage: widget.controller?.existedImageUrl,
                  onSelect: (selectedImage) {
                    setState(() {
                      if (selectedImage is File) {
                        selectedFile = selectedImage;
                        widget.controller?.existedImageUrl = null;
                      } else if (selectedImage is String) {
                        selectedFile = null;
                        widget.controller?.existedImageUrl = selectedImage;
                      }
                    });
                    widget.controller.image = selectedFile;
                    widget.onImageSelect?.call();
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
  File selectedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 263,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: ColorsRes.dialogDimBg,
              child: selectedFile.isNotNull
                  ? Image.file(
                      selectedFile,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.controller?.existedImageUrl ?? '',
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
                onTap: () {
                  showImagePickerDialog(
                    context: context,
                    images: widget.oldImages,
                    selectedExistedImage: widget.controller?.existedImageUrl,
                    onSelect: (selectedImage) {
                      setState(() {
                        if (selectedImage is File) {
                          selectedFile = selectedImage;
                          widget.controller?.existedImageUrl = null;
                        } else if (selectedImage is String) {
                          selectedFile = null;
                          widget.controller?.existedImageUrl = selectedImage;
                        }
                      });
                      widget.controller.image = selectedFile;
                      widget.onImageSelect?.call();
                    },
                  );
                },
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

Future showImagePickerDialog(
    {BuildContext context,
    List<String> images,
    String selectedExistedImage,
    void Function(dynamic selectedImage) onSelect}) async {
  await showKayleeBottomSheet(
    context,
    initialChildSize: 145 / 667,
    minChildSize: 145 / 667,
    builder: (c, scrollController) {
      return _ImageGrid(
        controller: scrollController,
        selectedExistedImage: selectedExistedImage,
        images: images,
        onSelect: (selectedImage) {
          context.pop();
          if (onSelect.isNotNull) {
            onSelect(selectedImage);
          }
        },
      );
    },
  );
}

class _ImageGrid extends StatefulWidget {
  final ScrollController controller;
  final List<String> images;
  final String selectedExistedImage;
  final void Function(dynamic selectedImage) onSelect;

  _ImageGrid(
      {@required this.controller,
      this.images,
      this.selectedExistedImage,
      this.onSelect});

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends BaseState<_ImageGrid> {
  String selectedExistedImage;

  @override
  void initState() {
    super.initState();
    selectedExistedImage = widget.selectedExistedImage;
  }

  Future<void> handlePermission() async {
    final Permission permission =
    Platform.isAndroid ? Permission.storage : Permission.photos;
    if (await permission.isGranted) {
      final pickedFile = await ImagePicker()
          .getImage(
          source: ImageSource.gallery, maxWidth: 2020, maxHeight: 2020);
      File selectedFile;
      if (pickedFile.isNotNull) {
        selectedFile = File(pickedFile.path);
      }
      widget.onSelect?.call(selectedFile);
    } else if (await permission.isDenied) {
      // print('[TUNG] ===> isDenied');
      if (Platform.isIOS) {
        await showKayleeGo2SettingDialog(context: context);
      } else {
        await permission.request();
        handlePermission();
      }
    } else if (await permission.isRestricted) {
      ///only support ios
      // print('[TUNG] ===> isRestricted');
      await showKayleeGo2SettingDialog(context: context);
    } else if (await permission.isPermanentlyDenied) {
      ///only support android
      // print('[TUNG] ===> isPermanentlyDenied');
      await showKayleeGo2SettingDialog(context: context);
    } else if (await permission.isUndetermined) {
      // print('[TUNG] ===> isUndetermined');
      await permission.request();
      handlePermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
          left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
      controller: widget.controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: Dimens.px16,
          mainAxisSpacing: Dimens.px16),
      itemBuilder: (c, index) {
        if (index == 0)
          return _BorderWrapper.static(
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
        else {
          final selectedImage = widget.images.elementAt(index - 1);
          return _BorderWrapper.dynamic(
            isSelected: selectedExistedImage == selectedImage,
            child: CachedNetworkImage(
              imageUrl: widget.images.elementAt(index - 1),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
            onTap: () {
              setState(() {
                selectedExistedImage = selectedImage;
              });
              if (widget.onSelect.isNotNull) {
                widget.onSelect(selectedExistedImage);
              }
            },
          );
        }
      },
      itemCount: (widget.images?.length ?? 0) + 1,
    );
  }
}

class _BorderWrapper extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final bool isStatic;
  final bool isSelected;

  factory _BorderWrapper.static({Widget child, void Function() onTap}) =>
      _BorderWrapper(
        child: child,
        onTap: onTap,
        isStatic: true,
      );

  factory _BorderWrapper.dynamic(
      {Widget child, void Function() onTap, bool isSelected = false}) =>
      _BorderWrapper(
        child: child,
        onTap: onTap,
        isStatic: false,
        isSelected: isSelected,
      );

  _BorderWrapper(
      {this.child, this.onTap, this.isStatic = false, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return KayleeInkwell(
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isStatic || !isSelected
                  ? ColorsRes.hintText
                  : ColorsRes.hyper,
              width: isStatic || !isSelected ? Dimens.px1 : Dimens.px2),
          borderRadius: BorderRadius.circular(Dimens.px10),
        ),
        child: child ?? Container(),
      ),
      onTap: () {
        if (onTap.isNotNull) {
          onTap();
        }
      },
    );
  }
}
