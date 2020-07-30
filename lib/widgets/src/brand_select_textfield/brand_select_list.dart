import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/brand_select_textfield/bloc/brand_select_list_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandSelectList extends StatefulWidget {
  final ScrollController scrollController;
  final BrandSelectTFController controller;

  BrandSelectList({this.scrollController, this.controller});

  @override
  _BrandSelectListState createState() => _BrandSelectListState();
}

class _BrandSelectListState extends BaseState<BrandSelectList> {
  int selectedIndex;
  final text = KayleeText.normal18W700(
    'Chọn cửa hàng cần áp dụng',
    maxLines: 1,
    textAlign: TextAlign.center,
  );
  BrandSelectListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BrandSelectListBloc(
      service: context.network.provideBrandService(),
      brands: widget.controller?.brands,
    )..loadBrands();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        text,
        Expanded(
            child: BlocBuilder<BrandSelectListBloc, SingleModel<List<Brand>>>(
              cubit: bloc,
              builder: (context, state) {
                if (state.loading == true)
                  return CupertinoActivityIndicator(
                    radius: Dimens.px16,
                  );
                return ListView.separated(
                    padding: const EdgeInsets.all(Dimens.px16),
                    controller: widget.scrollController,
                    itemBuilder: (c, index) {
                      final item = state.item.elementAt(index);
                      return BlocProvider<BrandSelectListBloc>.value(
                        value: bloc,
                        child: _BrandItem(
                          brand: item,
                        ),
                      );
                    },
                    separatorBuilder: (c, _) =>
                        SizedBox(
                          height: Dimens.px8,
                        ),
                    itemCount: state.item.length);
              },
        )),
        Container(
          height: Dimens.px1,
          width: double.infinity,
          color: ColorsRes.divider,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px8, vertical: Dimens.px16),
          child: Row(
            children: [
              Expanded(
                child: KayLeeRoundedButton.button2(
                  margin: EdgeInsets.zero,
                  text: Strings.huyBo,
                  onPressed: () {
                    popScreen();
                  },
                ),
              ),
              SizedBox(width: Dimens.px8),
              Expanded(
                child: KayLeeRoundedButton.normal(
                  margin: EdgeInsets.zero,
                  text: Strings.xacNhan,
                  onPressed: () {
                    widget.controller.brands = bloc.state.item..removeAt(0);
                    popScreen();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _BrandItem extends StatefulWidget {
  final Brand brand;

  _BrandItem({this.brand});

  @override
  _BrandItemState createState() => _BrandItemState();
}

class _BrandItemState extends BaseState<_BrandItem> {
  BrandSelectListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<BrandSelectListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandSelectListBloc, SingleModel<List<Brand>>>(
      buildWhen: (previous, current) {
        return current.item
            .singleWhere((e) => e.id == widget.brand.id, orElse: null)
            .isNotNull;
      },
      builder: (context, state) {
        return Material(
          clipBehavior: Clip.antiAlias,
          color: widget.brand.selected ? ColorsRes.hyper : ColorsRes.background,
          borderRadius: BorderRadius.circular(Dimens.px5),
          child: InkWell(
            onTap: () {
              bloc.select(
                  brand: widget.brand..selected = !widget.brand.selected);
            },
            child: Container(
              height: Dimens.px40,
              padding: const EdgeInsets.all(Dimens.px8),
              child: Row(
                children: [
                  Image.asset(
                    widget.brand.selected
                        ? Images.ic_checked_1
                        : Images.ic_notcheck,
                    width: Dimens.px24,
                    height: Dimens.px24,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Dimens.px8),
                      child: KayleeText(
                        widget.brand.name ?? '',
                        maxLines: 1,
                        style: widget.brand.selected
                            ? TextStyles.normalWhite16W400
                            : TextStyles.normal16W400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
