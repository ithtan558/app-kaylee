import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ServiceListScreen extends StatefulWidget {
  factory ServiceListScreen.newInstance() = ServiceListScreen._;

  ServiceListScreen._();

  @override
  _ServiceListScreenState createState() => new _ServiceListScreenState();
}

class _ServiceListScreenState extends BaseState<ServiceListScreen> {
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
    return KayleeFilterPopUpView(
      appBar: KayleeAppBar(
        title: Strings.danhMucDichVu,
        actions: <Widget>[
          ActionButton(
              child: SizedBox(
            height: kToolbarHeight,
            width: kToolbarHeight,
            child: InkWell(
              onTap: () {},
              customBorder: CircleBorder(),
              child: Center(
                child: ImageIcon(
                  AssetImage(
                    Images.ic_search,
                  ),
                  color: ColorsRes.hintText,
                  size: Dimens.px20,
                ),
              ),
            ),
          ))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (c, index) {
          return _buildProdList();
        },
        itemCount: 3,
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(context, CreateNewServiceScreen));
        },
      ),
    );
  }

  _buildProdList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
          child: KayleeText.normal16W500(
            "Chưa có danh mục (1)",
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
          ),
        ),
        KayleeGridView(
          padding: EdgeInsets.all(Dimens.px16),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 103 / 195,
          itemBuilder: (c, index) {
            return KayleeProdItemView.canTap(
              data: KayleeProdItemData(
                  name: 'Tóc kiểu thôn nữ',
                  image:
                      'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
                  price: 600000),
              onTap: () {},
            );
          },
          itemCount: 4,
        )
      ],
    );
  }
}
