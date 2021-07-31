import 'dart:io' as io;
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_plugin/core_plugin.dart' hide ImageSource;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

enum KayleeImagePickerType { profile, banner }

class ImagePickerController {
  File? image;

  ///image url from existed things;
  String? existedImageUrl;
}

class KayleeImagePicker extends StatelessWidget {
  final KayleeImagePickerType type;
  final List<String> oldImages;
  final ImagePickerController? controller;
  final VoidCallback? onImageSelect;

  const KayleeImagePicker({
    Key? key,
    this.type = KayleeImagePickerType.profile,
    this.onImageSelect,
    this.oldImages = const [],
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case KayleeImagePickerType.banner:
        return _KayleeBannerImagePicker(
          key: key,
          type: type,
          controller: controller,
          onImageSelect: onImageSelect,
          oldImages: oldImages,
        );
      default:
        return _KayleeProfileImagePicker(
          key: key,
          type: type,
          controller: controller,
          onImageSelect: onImageSelect,
          oldImages: oldImages,
        );
    }
  }
}

class _KayleeProfileImagePicker extends StatefulWidget {
  final KayleeImagePickerType type;
  final List<String> oldImages;
  final ImagePickerController? controller;
  final VoidCallback? onImageSelect;

  const _KayleeProfileImagePicker({
    Key? key,
    this.type = KayleeImagePickerType.profile,
    this.onImageSelect,
    this.oldImages = const [],
    this.controller,
  }) : super(key: key);

  @override
  _KayleeProfileImagePickerState createState() =>
      _KayleeProfileImagePickerState();
}

class _KayleeProfileImagePickerState
    extends BaseState<_KayleeProfileImagePicker> {
  File? selectedFile;

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
                side: const BorderSide(color: ColorsRes.hintText),
              ),
              child: (widget.controller?.existedImageUrl?.isEmpty ?? true) &&
                      selectedFile == null
                  ? Center(
                      child: Image.asset(
                        Images.icImageHolder,
                        width: Dimens.px40,
                        height: Dimens.px40,
                      ),
                    )
                  : AspectRatio(
                aspectRatio: 1,
                      child: selectedFile != null
                          ? Image.file(
                              selectedFile!,
                              fit: BoxFit.cover,
                            )
                          : (widget.controller?.existedImageUrl)
                                  .isNotNullAndEmpty
                              ? CachedNetworkImage(
                                  imageUrl: widget.controller!.existedImageUrl!,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox.shrink(),
                    ),
            ),
          ),
          SizedBox(
            height: Dimens.px56,
            width: context.screenSize.width * 243 / 375,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    ColorsRes.button.withOpacity(0.8)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(Dimens.px12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.px10))),
              ),
              clipBehavior: Clip.antiAlias,
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
                    widget.controller?.image = selectedFile;
                    widget.onImageSelect?.call();
                  },
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    Images.icCamera,
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

class _KayleeBannerImagePicker extends StatefulWidget {
  final KayleeImagePickerType type;
  final List<String> oldImages;
  final ImagePickerController? controller;
  final VoidCallback? onImageSelect;

  const _KayleeBannerImagePicker({
    Key? key,
    this.type = KayleeImagePickerType.profile,
    this.onImageSelect,
    this.oldImages = const [],
    this.controller,
  }) : super(key: key);

  @override
  _KayleeBannerImagePickerState createState() =>
      _KayleeBannerImagePickerState();
}

class _KayleeBannerImagePickerState
    extends BaseState<_KayleeBannerImagePicker> {
  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 263,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: ColorsRes.dialogDimBg,
              child: selectedFile != null
                  ? Image.file(
                      selectedFile!,
                      fit: BoxFit.cover,
                    )
                  : (widget.controller?.existedImageUrl).isNotNullAndEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.controller!.existedImageUrl!,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
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
                      widget.controller?.image = selectedFile;
                      widget.onImageSelect?.call();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.px12),
                  child: Row(
                    children: [
                      Image.asset(
                        Images.icCamera,
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
    {required BuildContext context,
    List<String>? images,
    String? selectedExistedImage,
    void Function(dynamic selectedImage)? onSelect}) async {
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
          onSelect?.call(selectedImage);
        },
      );
    },
  );
}

class _ImageGrid extends StatefulWidget {
  final ScrollController? controller;
  final List<String>? images;
  final String? selectedExistedImage;
  final void Function(dynamic selectedImage)? onSelect;

  const _ImageGrid(
      {required this.controller,
      this.images,
      this.selectedExistedImage,
      this.onSelect});

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends BaseState<_ImageGrid> {
  String? selectedExistedImage;

  @override
  void initState() {
    super.initState();
    selectedExistedImage = widget.selectedExistedImage;
  }

  Future<void> handlePermission() async {
    final Permission permission =
        io.Platform.isAndroid ? Permission.storage : Permission.photosAddOnly;
    final status = await permission.request();
    if (status.isGranted) {
      _openGallery();
    } else if (status.isDenied) {
      // print('[TUNG] ===> isDenied');
      if (Platform.isIOS) {
        await context.systemSetting
            .showKayleeGo2SettingDialog(context: context);
      } else {
        await permission.request();
        handlePermission();
      }
    } else if (status.isRestricted) {
      ///only support ios
      // print('[TUNG] ===> isRestricted');
      await context.systemSetting.showKayleeGo2SettingDialog(context: context);
    } else if (status.isPermanentlyDenied) {
      ///only support android
      // print('[TUNG] ===> isPermanentlyDenied');
      await context.systemSetting.showKayleeGo2SettingDialog(context: context);
    } else if (status.isLimited) {
      //only support ios
      //when user select option for only 1 time
      _openGallery();
    }
  }

  void _openGallery() async {
    final pickedFile = await image_picker.ImagePicker().pickImage(
        source: image_picker.ImageSource.gallery,
        maxWidth: 2020,
        maxHeight: 2020);
    io.File? selectedFile;
    if (pickedFile != null) {
      selectedFile = io.File(pickedFile.path);
    }
    if (selectedFile != null) {
      widget.onSelect?.call(selectedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
          left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
      controller: widget.controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: Dimens.px16,
          mainAxisSpacing: Dimens.px16),
      itemBuilder: (c, index) {
        if (index == 0) {
          return _BorderWrapper.static(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.icImageHolder,
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
        } else {
          final selectedImage = widget.images!.elementAt(index - 1);
          return _BorderWrapper.dynamic(
            isSelected: selectedExistedImage == selectedImage,
            child: CachedNetworkImage(
              imageUrl: selectedImage,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
            onTap: () {
              setState(() {
                selectedExistedImage = selectedImage;
              });
              widget.onSelect?.call(selectedExistedImage);
            },
          );
        }
      },
      itemCount: (widget.images?.length ?? 0) + 1,
    );
  }
}

class _BorderWrapper extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final bool isStatic;
  final bool isSelected;

  factory _BorderWrapper.static({Widget? child, VoidCallback? onTap}) =>
      _BorderWrapper(
        child: child,
        onTap: onTap,
        isStatic: true,
      );

  factory _BorderWrapper.dynamic(
          {Widget? child, VoidCallback? onTap, bool isSelected = false}) =>
      _BorderWrapper(
        child: child,
        onTap: onTap,
        isStatic: false,
        isSelected: isSelected,
      );

  const _BorderWrapper(
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
        child: child,
      ),
      onTap: () {
        onTap?.call();
      },
    );
  }
}
