import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/service/categories/detail/bloc/serv_cate_detail_bloc.dart';

class NewServCateScreenData {
  final NewSerCateScreenOpenFrom openFrom;
  final ServiceCate? serviceCate;

  NewServCateScreenData({required this.openFrom, this.serviceCate});
}

enum NewSerCateScreenOpenFrom { cateItem, addNewCateBtn }

class CreateNewServCateScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ServCateDetailBloc(
        servService: context.api.service,
            serviceCate:
                context.getArguments<NewServCateScreenData>()!.serviceCate,
          ),
      child: const CreateNewServCateScreen());

  @visibleForTesting
  const CreateNewServCateScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewServCateScreenState createState() =>
      _CreateNewServCateScreenState();
}

class _CreateNewServCateScreenState
    extends KayleeState<CreateNewServCateScreen> {
  ServCateDetailBloc get _bloc => context.bloc<ServCateDetailBloc>()!;
  late NewSerCateScreenOpenFrom openFrom;
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
        } else if (state is DeleteServCateModel ||
            state is NewServCateModel ||
            state is UpdateServCateModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>()!.reload(widget: ServCateListScreen);
              popScreen();
            },
          );
        }
      }
    });

    final data = context.getArguments<NewServCateScreenData>()!;
    openFrom = data.openFrom;
    if (openFrom == NewSerCateScreenOpenFrom.cateItem) {
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
          title: openFrom == NewSerCateScreenOpenFrom.cateItem
              ? Strings.chinhSuaDanhMuc
              : Strings.taoDanhMucMoi,
          actionTitle: openFrom == NewSerCateScreenOpenFrom.cateItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {
            if (openFrom == NewSerCateScreenOpenFrom.cateItem) {
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
              _bloc.state.item = ServiceCate()
                ..name = nameTfController.text
                ..code = codeTfController.text
                ..sequence = int.tryParse(sequenceTfController.text);
              _bloc.create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocConsumer<ServCateDetailBloc, SingleModel<ServiceCate>>(
          listener: (context, state) {
            nameTfController.text = state.item?.name ?? '';
            codeTfController.text = state.item?.code ?? '';
            sequenceTfController.text = state.item?.sequence?.toString() ?? '';
          },
          listenWhen: (previous, current) => current is DetailServCateModel,
          buildWhen: (previous, current) => current is DetailServCateModel,
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
        bottom: openFrom == NewSerCateScreenOpenFrom.cateItem
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
