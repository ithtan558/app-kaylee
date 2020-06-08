import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CreateNewBranchScreen extends StatefulWidget {
  factory CreateNewBranchScreen.newInstance() = CreateNewBranchScreen._;

  CreateNewBranchScreen._();

  @override
  _CreateNewBranchScreenState createState() => _CreateNewBranchScreenState();
}

class _CreateNewBranchScreenState extends State<CreateNewBranchScreen> {
  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar(
          title: Strings.taoChiNhanhMoi,
          actions: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: Dimens.px16),
              child: HyperLinkText(
                text: Strings.tao,
                onTap: () {},
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              KayleeImagePicker(
                type: KayleeImagePickerType.banner,
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.px16),
                child: KayleeTextField.normal(
                  title: Strings.tenCuaHang,
                  hint: Strings.tenCuaHangHint,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleeTextField.website(
                  title: Strings.tenMienWebSiteCuaBan,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleeFullAddressInput(
                  title: Strings.diaChi,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleeTextField.phoneInput(
                  title: Strings.soDienThoai,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeTextField.selection(
                        title: Strings.gioMoCua,
                      ),
                    ),
                    SizedBox(width: Dimens.px8),
                    Expanded(
                      child: KayleeTextField.selection(
                        title: Strings.gioDongCua,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
