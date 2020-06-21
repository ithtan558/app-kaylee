import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/contact_us_bloc.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ContactUsText extends StatefulWidget {
  static Widget newInstance() => BlocProvider<ContactUsBloc>(
        create: (context) => ContactUsBloc(
            context.repository<NetworkModule>().provideCommonService()),
        child: ContactUsText._(),
      );

  ContactUsText._();

  @override
  _ContactUsTextState createState() => _ContactUsTextState();
}

class _ContactUsTextState extends KayleeState<ContactUsText> {
  ContactUsBloc contactUsBloc;

  @override
  void initState() {
    super.initState();
    contactUsBloc = context.bloc<ContactUsBloc>();
  }

  @override
  void dispose() {
    contactUsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactUsBloc, dynamic>(
      listener: (context, state) {
        if (state is ErrorState) {
          hideLoading();
          showKayleeAlertDialog(
              context: context,
              view: KayleeAlertDialogView.error(
                error: state.error,
                actions: [
                  KayleeAlertDialogAction.dongY(
                    onPressed: () {
                      popScreen();
                    },
                  ),
                ],
              ));
        } else if (state is LoadingState) {
          showLoading();
        } else if (state is SuccessLoadContactUsState) {
          hideLoading();
          makeCall(state.content.content);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            Strings.cauHoiKhacVeDangNhapDangKy,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.px8),
            child: HyperLinkText(
              text: Strings.lienHeChungToi,
              onTap: () {
                contactUsBloc.getContact();
              },
            ),
          ),
        ],
      ),
    );
  }
}
