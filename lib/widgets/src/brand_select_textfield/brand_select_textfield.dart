import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/brand_select_textfield/bloc/brand_select_tf_bloc.dart';
import 'package:kaylee/widgets/src/brand_select_textfield/brand_select_list.dart';

class BrandSelectTextField extends StatefulWidget {
  final String? error;
  final String? title;
  final BrandSelectTFController? controller;

  const BrandSelectTextField(
      {Key? key, this.error, this.title, this.controller})
      : super(key: key);

  @override
  _BrandSelectTextFieldState createState() => _BrandSelectTextFieldState();
}

class _BrandSelectTextFieldState extends State<BrandSelectTextField> {
  late BrandSelectTfBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BrandSelectTfBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

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
                child: BlocBuilder<BrandSelectTfBloc, dynamic>(
                  bloc: bloc,
                  builder: (context, state) {
                    return KayleeText.normal16W400(
                      '(${widget.controller?.count ?? 0}) địa điểm được chọn',
                      maxLines: 1,
                    );
                  },
                ),
              ),
              KayleeFlatButton.withTextField(
                title: Strings.chinhSua,
                onPress: () {
                  showKayleeBottomSheet(
                    context,
                    initialChildSize: 356 / 667,
                    minChildSize: 356 / 667,
                    builder: (c, scrollController) {
                      return BrandSelectList(
                        scrollController: scrollController,
                        controller: widget.controller,
                      );
                    },
                  ).then((value) {
                    bloc.update();
                  });
                },
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
  List<Brand>? brands;

  int get count => (brands?.where((e) => e.selected))?.length ?? 0;

  String? get brandIds =>
      ((brands?.where((e) => e.selected))?.map((e) => e.id))?.join(',');
}
