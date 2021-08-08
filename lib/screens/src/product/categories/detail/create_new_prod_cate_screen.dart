import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/product/categories/detail/bloc/prod_cate_detail_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewProdCateScreenData {
  final NewProdCateScreenOpenFrom openFrom;
  final ProdCate? prodCate;

  NewProdCateScreenData({required this.openFrom, this.prodCate});
}

enum NewProdCateScreenOpenFrom { cateItem, addNewCateBtn }

class CreateNewProdCateScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ProdCateDetailBloc(
        productService: locator.apis.provideProductApi(),
            prodCate: context.getArguments<NewProdCateScreenData>()!.prodCate,
          ),
      child: const CreateNewProdCateScreen());

  @visibleForTesting
  const CreateNewProdCateScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewProdCateScreenState createState() =>
      _CreateNewProdCateScreenState();
}

class _CreateNewProdCateScreenState
    extends KayleeState<CreateNewProdCateScreen> {
  ProdCateDetailBloc get _bloc => context.bloc<ProdCateDetailBloc>()!;
  late NewProdCateScreenOpenFrom openFrom;
  late StreamSubscription _sub;
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final codeTfController = TextEditingController();
  final codeFocus = FocusNode();
  final sequenceTfController = TextEditingController();
  final sequenceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _sub = _bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: popScreen,
          );
        } else if (state is DeleteProductCateModel ||
            state is NewProductCateModel ||
            state is UpdateProductCateModel) {
          context.bloc<ReloadBloc>()!.reload(widget: ProdCateListScreen);
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>()!.reload(widget: ProdCateListScreen);
              popScreen();
            },
          );
        }
      }
    });

    final data = context.getArguments<NewProdCateScreenData>()!;
    openFrom = data.openFrom;
    if (openFrom == NewProdCateScreenOpenFrom.cateItem) {
      _bloc.get();
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    nameTfController.dispose();
    codeTfController.dispose();
    sequenceTfController.dispose();

    nameFocus.dispose();
    codeFocus.dispose();
    sequenceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == NewProdCateScreenOpenFrom.cateItem
              ? Strings.chinhSuaDanhMuc
              : Strings.taoDanhMucMoi,
          actionTitle: openFrom == NewProdCateScreenOpenFrom.cateItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {
            if (openFrom == NewProdCateScreenOpenFrom.cateItem) {
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView(
                    title: Strings.banDaChacChan,
                    content: Strings.banCoDongYLuuLaiNhungThayDoi,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          popScreen();
                          _bloc.state.item!
                            ..name = nameTfController.text
                            ..code = codeTfController.text
                            ..sequence =
                                int.tryParse(sequenceTfController.text);
                          _bloc.update();
                        },
                        isDefaultAction: true,
                      ),
                      KayleeAlertDialogAction.huy(
                        onPressed: popScreen,
                      ),
                    ],
                  ));
            } else {
              _bloc.state.item = ProdCate()
                ..name = nameTfController.text
                ..code = codeTfController.text
                ..sequence = int.tryParse(sequenceTfController.text);
              _bloc.create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocConsumer<ProdCateDetailBloc, SingleModel<ProdCate>>(
          listener: (context, state) {
            nameTfController.text = state.item?.name ?? '';
            codeTfController.text = state.item?.code ?? '';
            sequenceTfController.text = state.item?.sequence?.toString() ?? '';
          },
          listenWhen: (previous, current) => current is DetailProductCateModel,
          buildWhen: (previous, current) => current is DetailProductCateModel,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.tenDanhMuc,
                    hint: Strings.nhapTenDanhMuc,
                    controller: nameTfController,
                    focusNode: nameFocus,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: codeFocus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.maCode,
                    hint: Strings.nhapMaCode,
                    controller: codeTfController,
                    focusNode: codeFocus,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: sequenceFocus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.viTri,
                    hint: Strings.nhapViTri,
                    controller: sequenceTfController,
                    focusNode: sequenceFocus,
                  ),
                ),
              ],
            );
          },
        ),
        bottom: openFrom == NewProdCateScreenOpenFrom.cateItem
            ? Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, bottom: Dimens.px32),
                child: HyperLinkText(
                  text: Strings.xoaDanhMuc,
                  onTap: () {
                    showKayleeAlertDialog(
                        context: context,
                        view: KayleeAlertDialogView(
                          title: Strings.banDaChacChan,
                          content:
                              Strings.banCoDongYXoaThongTinVaKhongPhucHoiLai,
                          actions: [
                            KayleeAlertDialogAction.dongY(
                              onPressed: () {
                                popScreen();
                                _bloc.delete();
                              },
                              isDefaultAction: true,
                            ),
                            KayleeAlertDialogAction.huy(
                              onPressed: popScreen,
                            ),
                          ],
                        ));
                  },
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
