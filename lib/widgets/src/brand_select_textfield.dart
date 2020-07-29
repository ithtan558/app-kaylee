import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandSelectTextField extends StatefulWidget {
  final String error;
  final String title;

  BrandSelectTextField({
    this.error,
    this.title,
  });

  @override
  _BrandSelectTextFieldState createState() => _BrandSelectTextFieldState();
}

class _BrandSelectTextFieldState extends State<BrandSelectTextField> {
  @override
  Widget build(BuildContext context) {
    return KayleeTextField(
      title: widget.title,
      textInput: ErrorText(
        child: TextFieldBorderWrapper(Padding(
          padding: const EdgeInsets.only(
              left: Dimens.px16,
              right: Dimens.px4,
              bottom: Dimens.px4,
              top: Dimens.px4),
          child: Row(
            children: [
              Expanded(
                  child: KayleeText.normal16W400(
                widget.content ?? '',
                maxLines: 1,
              )),
              KayleeFlatButton.withTextField(
                title: Strings.chinhSua,
                onPress: () {},
              )
            ],
          ),
        )),
        error: widget.error,
      ),
    );
  }
}

class BrandSelectTFController {
  List<Brand> brands;

  String get brandIds => brands?.map((e) => e.id)?.join(',');
}
