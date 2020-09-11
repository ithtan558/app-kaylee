import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/images.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/splash/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  static Widget newInstance() =>
      BlocProvider(create: (c) => SplashScreenBloc(), child: SplashScreen._());

  SplashScreen._();

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  final logoRatio = 211 / 95;
  SplashScreenBloc bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<SplashScreenBloc>();
    bloc.config();
    _sub = context.bloc<AppBloc>().listen((state) {
      if (state is DoneSetupLoggedInState) {
        bloc.userService = context.network.provideUserService();
        bloc.loadUserInfo();
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: context.scaleWidth(211),
                height: double.infinity,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: logoRatio,
                  child: Image.asset(Images.logo),
                ),
              ),
            ),
            BlocConsumer<SplashScreenBloc, dynamic>(
              builder: (context, state) {
                if (state is LoadedSharedPrefSplashScrState) {
                  final user = context.user.getUserInfo();
                  if (user?.token.isNullOrEmpty) {
                    return Column(
                      children: [
                        KayLeeRoundedButton.normal(
                          onPressed: () {
                            pushScreen(PageIntent(screen: LoginScreen));
                          },
                          text: Strings.login,
                        ),
                        Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: Dimens.px32),
                          child: Go2RegisterText(),
                        )
                      ],
                    );
                  }
                }
                return Container();
              },
              listener: (context, state) {
                if (state is GoToHomeScreenSplashScrState) {
                  context.pushToTop(PageIntent(screen: HomeScreen));
                } else if (state is LoadedSharedPrefSplashScrState) {
                  final user = context.user?.getUserInfo();
                  if (user?.token.isNotNullAndEmpty) {
                    context.bloc<AppBloc>().loggedIn(user);
                  }
                } else if (state is LoadedUserInfoState) {
                  context.user.updateUserInfo(
                      context.user.getUserInfo()..userInfo = state.userInfo);
                  bloc.pushToHomeScreen();
                } else if (state is ErrorLoadInfoState) {
                  showKayleeAlertErrorYesDialog(
                    context: context,
                    error: state.error,
                    onPressed: popScreen,
                    onDismiss: () {
                      bloc.pushToHomeScreen();
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
