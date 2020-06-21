import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/update_pass_bloc.dart';
import 'package:kaylee/screens/src/reset_pass/widgets/contact_us_text.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class NewPassScreenData {
  VerifyOtpResult result;

  NewPassScreenData({this.result});
}

class ResetPassNewPassScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<UpdatePassBloc>(
        create: (context) => UpdatePassBloc(
            context.repository<NetworkModule>().provideUserService()),
        child: ResetPassNewPassScreen._(),
      );

  ResetPassNewPassScreen._();

  @override
  _ResetPassNewPassScreenState createState() =>
      new _ResetPassNewPassScreenState();
}

class _ResetPassNewPassScreenState extends KayleeState<ResetPassNewPassScreen> {
  UpdatePassBloc updatePassBloc;

  @override
  void initState() {
    super.initState();
    updatePassBloc = context.bloc<UpdatePassBloc>();
  }

  @override
  void dispose() {
    updatePassBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
        child: Scaffold(
          appBar: KayleeAppBar(
            title: Strings.nhapMatKhauMoi,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: Dimens.px16,
                bottom: Dimens.px32,
                left: Dimens.px16,
                right: Dimens.px16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocConsumer<UpdatePassBloc, dynamic>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      hideLoading();
                      showKayleeAlertErrorYesDialog(
                        context: context,
                        error: state.error,
                        onPressed: () {
                          popScreen();
                        },
                      );
                    } else if (state is PassErrorUpdatePassState) {
                      hideLoading();
                    } else if (state is LoadingState) {
                      showLoading();
                    } else if (state is SuccessSendNewPassUpdatePassState) {
                      hideLoading();
                    }
                  },
                  builder: (context, state) {
                    return KayleeTextField.password(
                      title: Strings.matKhauMoi,
                      textInputAction: TextInputAction.done,
                      hint: Strings.passLimitHint,
                      error:
                      state is PassErrorUpdatePassState ? state.message : null,
                    );
                  },
                ),
                KayLeeRoundedButton.normal(
                  margin: EdgeInsets.only(top: Dimens.px16),
                  onPressed: () {
//                pushScreen(PageIntent(context, ));
                  },
                  text: Strings.xacNhan,
                ),
                Expanded(child: ContactUsText.newInstance())
              ],
            ),
          ),
        ));
  }
}
