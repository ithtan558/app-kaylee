import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/contact_us_bloc.dart';

class ContactUsText extends StatefulWidget {
  static Widget newInstance() => BlocProvider<ContactUsBloc>(
    create: (context) => ContactUsBloc(context.api.common),
        child: const ContactUsText._(),
      );

  const ContactUsText._();

  @override
  _ContactUsTextState createState() => _ContactUsTextState();
}

class _ContactUsTextState extends KayleeState<ContactUsText> {
  ContactUsBloc get contactUsBloc => context.bloc<ContactUsBloc>()!;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactUsBloc, dynamic>(
      listener: (context, state) {
        if (state is ErrorState && state.error != null) {
          hideLoading();
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
            },
          );
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
          const Text(
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
