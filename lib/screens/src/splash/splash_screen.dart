import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
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

class _SplashScreenState extends KayleeState<SplashScreen> {
  final logoRatio = 211 / 95;
  SplashScreenBloc bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<SplashScreenBloc>();
    RemoteConfig.instance.then((value) async {
      value.setDefaults(context.appConfig.defaultConfig);
      await value.setConfigSettings(RemoteConfigSettings(
        debugMode: kDebugMode,
      ));
      await value.fetch(expiration: Duration(hours: 23));
      await value.activateFetched();
      context.appConfig.setupConfig(value.getAll());
      context.network.dio.options.baseUrl = context.appConfig.baseUrl;
      context.bloc<AppBloc>().packageInfo = await PackageInfo.fromPlatform();
      bloc.config();
    });
    _sub = context.bloc<AppBloc>().listen((state) {
      if (state is DoneSetupLoggedInState) {
        if (ModalRoute.of(context).isCurrent) {
          bloc.loadUserInfo(userService: context.network.provideUserService());
        }
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
                          text: Strings.dangNhap,
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
                } else if (state is ErrorLoadInfoState && state.error != null) {
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
