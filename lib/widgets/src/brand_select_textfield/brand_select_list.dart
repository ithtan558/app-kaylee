import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/brand_select_textfield/bloc/brand_select_list_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandSelectList extends StatefulWidget {
  final ScrollController? scrollController;
  final BrandSelectTFController? controller;

  const BrandSelectList({Key? key, this.scrollController, this.controller})
      : super(key: key);

  @override
  _BrandSelectListState createState() => _BrandSelectListState();
}

class _BrandSelectListState extends BaseState<BrandSelectList> {
  int? selectedIndex;
  final text = KayleeText.normal18W700(
    'Chọn cửa hàng cần áp dụng',
    maxLines: 1,
    textAlign: TextAlign.center,
  );
  late BrandSelectListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BrandSelectListBloc(
      service: locator.apis.provideBrandApi(),
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
          bloc: bloc,
          builder: (context, state) {
            if (state.loading == true) {
              return const KayleeLoadingIndicator();
            }
            return ListView.separated(
                padding: const EdgeInsets.all(Dimens.px16),
                controller: widget.scrollController,
                itemBuilder: (c, index) {
                  final item = state.item!.elementAt(index);
                  return BlocProvider<BrandSelectListBloc>.value(
                    value: bloc,
                    child: _BrandItem(
                      brand: item,
                    ),
                  );
                },
                separatorBuilder: (c, _) => const SizedBox(height: Dimens.px8),
                itemCount: state.item?.length ?? 0);
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
              const SizedBox(width: Dimens.px8),
              Expanded(
                child: KayLeeRoundedButton.normal(
                  margin: EdgeInsets.zero,
                  text: Strings.xacNhan,
                  onPressed: () {
                    widget.controller?.brands =
                        bloc.state.item?.sublist(1, bloc.state.item!.length);
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

  const _BrandItem({required this.brand});

  @override
  _BrandItemState createState() => _BrandItemState();
}

class _BrandItemState extends BaseState<_BrandItem> {
  BrandSelectListBloc get bloc => context.bloc<BrandSelectListBloc>()!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandSelectListBloc, SingleModel<List<Brand>>>(
      buildWhen: (previous, current) {
        try {
          current.item?.singleWhere((e) => e.id == widget.brand.id);
          return true;
        } catch (_) {
          return false;
        }
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
                  KayleeCheckBox(
                    checked: widget.brand.selected,
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
