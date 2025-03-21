import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/account/cubit/delete_account_cubit.dart';
import 'package:kaylee/screens/src/home/tabs/account/widgets/profile_widget.dart';
import 'package:kaylee/utils/utils.dart';

class AccountTab extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => DeleteAccountCubit(
            userApi: context.api.user,
            userInfo: context.user.getUserInfo().userInfo!,
          ),
        )
      ], child: const AccountTab());

  const AccountTab({Key? key}) : super(key: key);

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends KayleeState<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: BlocListener<DeleteAccountCubit, SingleModel>(
          listener: (context, state) {
            if (state.loading) {
              showLoading();
            }

            if (!state.loading) {
              hideLoading();
              if (state is DeleteAccountState) {
                context.read<AppBloc>().loggedOut();
              } else if (state.error != null) {
                showKayleeAlertErrorYesDialog(
                  context: context,
                  error: state.error,
                  onPressed: popScreen,
                );
              }
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileWidget(),
                _buildMenuItem(
                    title: Strings.thongBao,
                    icon: Images.icAccNotify,
                    onClick: () {
                      pushScreen(PageIntent(screen: NotificationScreen));
                    }),
                _buildMenuItem(
                    title: Strings.huongDanSd,
                    icon: Images.icAccGuide,
                    onClick: () {
                      pushScreen(PageIntent(screen: GuideScreen));
                    }),
                _buildMenuItem(
                    title: Strings.thongTinUngDung,
                    icon: Images.icAccAboutApp,
                    onClick: () {
                      pushScreen(PageIntent(screen: AboutScreen));
                    }),
                if ([UserRole.manager, UserRole.brandManager]
                    .contains(context.user.getUserInfo().userInfo?.role))
                  _buildMenuItem(
                      title: Strings.quanlyDonDh,
                      icon: Images.icAccOrderlist,
                      onClick: () {
                        pushScreen(PageIntent(screen: MyOrdersScreen));
                      }),
                _buildMenuItem(
                    title: Strings.caiDatMayIn,
                    icon: Images.icAccPrinter,
                    onClick: () {
                      pushScreen(PageIntent(screen: PrinterDetailScreen));
                    }),
                _buildMenuItem(
                    title: Strings.giaHanUngDung,
                    icon: Images.icAccGuide,
                    onClick: () {
                      pushScreen(PageIntent(screen: ExpirationScreen));
                    }),
                _buildMenuItem(
                    title: Strings.giaHanUngDung,
                    icon: Images.icAccGuide,
                    onClick: () {
                      pushScreen(PageIntent(screen: ExpirationScreen));
                    }),
                _buildMenuItem(
                    title: Strings.xoaTaiKhoan,
                    icon: Images.icAccGuide,
                    showEndingIcon: false,
                    onClick: () {
                      //todo show
                      showKayleeAlertDialog(
                          context: context,
                          view: KayleeAlertDialogView(
                            content: Strings.banCoChacChanHanhDongNay,
                            actions: [
                              KayleeAlertDialogAction.huy(
                                onPressed: context.pop,
                              ),
                              KayleeAlertDialogAction.dongY(
                                onPressed: () {
                                  popScreen();
                                  context.read<DeleteAccountCubit>().delete();
                                },
                              ),
                            ],
                          ),
                          onDismiss: () {});
                    }),
                _buildMenuItem(
                    title: Strings.dangXuat,
                    icon: Images.icAccLogout,
                    showBtmDivider: false,
                    showEndingIcon: false,
                    onClick: context.bloc<AppBloc>()!.loggedOut),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildMenuItem(
      {required String title,
      required String icon,
      bool showEndingIcon = true,
      bool showBtmDivider = true,
      VoidCallback? onClick}) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.px24, horizontal: Dimens.px16),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: Dimens.px32,
                  height: Dimens.px32,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimens.px16),
                    child: KayleeText.normal16W400(
                      title,
                      maxLines: 1,
                    ),
                  ),
                ),
                if (showEndingIcon)
                  Image.asset(
                    Images.icRight,
                    width: Dimens.px16,
                    height: Dimens.px16,
                  )
              ],
            ),
          ),
        ),
        if (showBtmDivider)
          Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              decoration: const BoxDecoration(color: ColorsRes.textFieldBorder))
      ],
    );
  }
}
